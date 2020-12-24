const std = @import("std");
const mem = std.mem;
const io = std.io;
const d_print = std.debug.print;

const MAX_FILE_SIZE = 20_000;
const MAX_VALUES = 1500;

const CrackError = error {
    outOfMemory,
    didNotFind,
};

const XMASCracker = struct {
    const Self = @This();

    values: [MAX_VALUES]u64,
    length: usize,

    inline fn unsafe_get(self: Self, index: usize) u64 {
        return self.values[index];
    }

    inline fn add_value(self: *Self, value: u64) !void {
        if (self.length >= MAX_VALUES) return CrackError.outOfMemory;

        self.values[self.length] = value;
        self.length += 1;
    }

    inline fn locate_weakness(self: Self, comptime preamble: usize, comptime previous_range: usize) !usize {
        var weakness: usize = 0;

        var index = preamble;
        while (index < self.length) : (index += 1) {
            var check_range: usize = 0;
            if (@subWithOverflow(usize, index, previous_range, &check_range)) check_range = 0;

            var did_match: bool = false;
            var i: usize = index;
            search: while (i > check_range) : (i -= 1) {
                var j: usize = i;
                while (j > check_range) {
                    // don't include ': (j -= 1)' in loop as it seems zig currently has a bug 
                    // which will cause overflowing j on loop exit, which again causes 
                    // the zig runtime to panic in debug mode* and safe release.
                    j -= 1; 
                    did_match = self.values[i] + self.values[j] == self.values[index];
                    if (did_match) break :search;
                }
            }

            if (!did_match) return index;
        }

        return CrackError.didNotFind;
    }

    inline fn crack(self: Self, weakness_index: usize) !usize {
        const weakness = self.values[weakness_index];
        
        var start: usize = 0;
        while (start < self.length) : (start += 1) {
            
            var smallest        = self.values[start];
            var biggest         = self.values[start];
            var maybe_weakness  = self.values[start];

            var end: usize = start + 1;
            search: while (end < self.length) : (end += 1) {
                const end_val = self.values[end];
                
                if (end_val < smallest) {
                    smallest = end_val;
                } else if (end_val > biggest) {
                    biggest = end_val;
                }

                maybe_weakness += end_val;

                if (maybe_weakness > weakness) break :search;
                if (maybe_weakness == weakness) return smallest + biggest;
            }
        }

        return CrackError.didNotFind;
    }
};

pub fn main() anyerror!void {
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var bytes: [MAX_FILE_SIZE]u8 = undefined;
    const length = try in.readAll(&bytes);

    var nut_cracker = XMASCracker {
        .values = undefined,
        .length = 0,
    };

    var it = mem.split(bytes[0..length], "\n");
    while (it.next()) |line| {
        if (line.len <= 0) break; 

        const value = try std.fmt.parseInt(u64, line, 10);
        try nut_cracker.add_value(value);
    }

    const w_index = try nut_cracker.locate_weakness(25, 25);
    const part1 = nut_cracker.unsafe_get(w_index);
    const part2 = try nut_cracker.crack(w_index);

    try stdout.print("{}\n{}\n", .{part1, part2});
}
