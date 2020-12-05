const std = @import("std");
const mem = std.mem;
const io = std.io;
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

const FromBytesError = error {
    UnexpectedChar,
    MissingExpectedChar,
};

const RequirementPassword = struct {
    char: u8,
    min: usize,
    max: usize,
    password: []const u8,

    pub inline fn fromBytes(bytes: []const u8) FromBytesError!RequirementPassword {
        if (bytes.len < 3) return FromBytesError.MissingExpectedChar; 

        var dash_pos: usize = mem.indexOfScalar(u8, bytes, '-').?;
        var space_pos: usize = mem.indexOfScalarPos(u8, bytes, dash_pos, ' ').?;

        // TODO: if space_pos == 0: Error

        var min: usize = 0;
        if (std.fmt.parseInt(usize, bytes[0..dash_pos], 10)) |ok| {
            min = ok;
        } else |err| {
            return FromBytesError.UnexpectedChar;
        }

        var max: usize = 0;
        if (std.fmt.parseInt(usize, bytes[dash_pos+1..space_pos], 10)) |ok| {
            max = ok;
        } else |err| {
            return FromBytesError.UnexpectedChar;
        }

        const char = bytes[space_pos+1];

        // 3 = skip char, colon and space
        // TODO: currently this include whitespace characters

        const password = mem.trim(u8, bytes[space_pos+3..bytes.len], &std.ascii.spaces);

        return RequirementPassword {
            .min = min,
            .max = max,
            .char = char,
            .password = password
        };
    }

    pub inline fn oldValid(self: RequirementPassword) bool {
        var occurence: u32 = 0;

        for (self.password) |char| {
            if (self.char == char) {
                occurence += 1;
                if (occurence > self.max) return false;
            }
        }

        return occurence >= self.min;
    }

     pub inline fn newValid(self: RequirementPassword) bool {
        var min_occurence: usize = @boolToInt(self.password[self.min - 1] == self.char);
        var max_occurence: usize = @boolToInt(self.password[self.max - 1] == self.char);
        return @as(usize, min_occurence) + @as(usize, max_occurence) == 1;
    }
};

fn bytesToRPPArrayList(allocator: *Allocator, bytes: []u8) !ArrayList(RequirementPassword) {
    var list = try ArrayList(RequirementPassword).initCapacity(allocator, 2000);

    var it = mem.split(bytes, "\n");
    var i: u32 = 0;
    while (it.next()) |raw_line| {
        // TODO: call parse function
        if (raw_line.len == 0) continue; 

        i += 1;
        if (RequirementPassword.fromBytes(raw_line)) |ok| {
            try list.append(ok);
        } else |err| {
            switch (err) {
                FromBytesError.UnexpectedChar => std.debug.warn("Unexpected character in line: {}\n", .{raw_line}),
                FromBytesError.MissingExpectedChar => std.debug.warn("Missing expected character in line: {}\n", .{raw_line}),
            }
        }
    }

    return list;
}

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = &arena.allocator;

    const in = std.io.getStdIn().inStream();
    const stdout = std.io.getStdOut().writer();

    // Hopefully enough ..
    // TODO: probably better to use ArrayList
    var buf: [25000]u8 = undefined;

    const length = try in.readAll(&buf);

    var parsed_input = try bytesToRPPArrayList(allocator, buf[0..length]);

    var old_valid: u32 = 0;
    for (parsed_input.items) |password_req_pair| {
        if (password_req_pair.oldValid()) {
            old_valid += 1;
        }
    }
    try stdout.print("{}\n", .{old_valid});

    var new_valid: u32 = 0;
    for (parsed_input.items) |password_req_pair| {
        if (password_req_pair.newValid()) {
            new_valid += 1;
        }
    }
    try stdout.print("{}\n", .{new_valid});
}