const std = @import("std");
const mem = std.mem;
const io = std.io;

const MAX_FILE_SIZE = 25_000; 

const PassportField = enum(u8) {
    invalid = 0b00000000, 
    cid = 0b00000001,
    byr = 0b00000010,
    iyr = 0b00000100,
    eyr = 0b00001000,
    hgt = 0b00010000, 
    hcl = 0b00100000,
    ecl = 0b01000000,
    pid = 0b10000000,
    required = 0b11111110,

    inline fn fromString(str: []const u8) PassportField {
            
            if (mem.eql(u8, str, "byr")) return PassportField.byr;
            if (mem.eql(u8, str, "iyr")) return PassportField.iyr;
            if (mem.eql(u8, str, "eyr")) return PassportField.eyr;
            if (mem.eql(u8, str, "hgt")) return PassportField.hgt;
            if (mem.eql(u8, str, "hcl")) return PassportField.hcl;
            if (mem.eql(u8, str, "ecl")) return PassportField.ecl;
            if (mem.eql(u8, str, "pid")) return PassportField.pid;
            if (mem.eql(u8, str, "cid")) return PassportField.cid;
            
            return PassportField.invalid;
    }

    fn validate(self: PassportField, field_value: []const u8) !bool {
        // TODO: investigate if zig has regex in std (would probably be slower though)

        switch(self) {
            .byr, .iyr, .eyr => {
                const value: i32 = try std.fmt.parseInt(i32, field_value, 10);

                switch(self) {
                    .byr => return value >= 1920 and value <= 2002,
                    .iyr => return value >= 2010 and value <= 2020,
                    .eyr => return value >= 2020 and value <= 2030,
                    else => unreachable,
                }
            },

            .hgt => {
                const m_index = field_value.len - 2;

                const measure = field_value[m_index..field_value.len];
                const value = try std.fmt.parseInt(i32, field_value[0..m_index], 10);

                if (mem.eql(u8, measure, "cm")) {
                    return value >= 150 and value <= 193;
                }
                
                if (mem.eql(u8, measure, "in")) {
                    return value >= 59 and value <= 76;
                } 

                return false;
            },

            .hcl => {
                if (field_value[0] != '#') return false;

                var i: usize = 1;
                while (i < field_value.len) : (i += 1) {
                    if (i > 6) return false;

                    switch (field_value[i]) {
                        'a'...'f', '0'...'9' => continue,
                        else =>  return false,
                    }
                }

                return true;
            }, 

            .ecl => {
                if (mem.eql(u8, field_value, "amb")
                    or mem.eql(u8, field_value, "blu")
                    or mem.eql(u8, field_value, "brn")
                    or mem.eql(u8, field_value, "gry")
                    or mem.eql(u8, field_value, "grn")
                    or mem.eql(u8, field_value, "hzl")
                    or mem.eql(u8, field_value, "oth")
                ) return true;

                return false;
            },

            .pid => {
                if (field_value.len != 9) return false;

                var i: usize = 0;
                while(i < field_value.len) : (i += 1) {
                    switch (field_value[i]) {
                        '0'...'9' => continue,
                        else => return false,
                    }
                }

                return true;
            }, 

            else => return true,
        }

        unreachable;
    }
};


pub inline fn countValidPass(bytes: []u8) struct {naive: u32, improved: u32} {
    var maybe_valid_passports: u32 = 0;
    var valid_passports: u32 = 0;

    var fields_found_map: u8 = 0; 
    var fields_valid: bool = true; 
    var lines = mem.split(bytes, "\n");

    line_read: while (lines.next()) |line| {

        if (line.len <= 2) {
            if (fields_found_map >= @enumToInt(PassportField.required)) {
                maybe_valid_passports += 1;
                valid_passports += @boolToInt(fields_valid);
            }

            fields_valid = true;
            fields_found_map = @enumToInt(PassportField.invalid);
            continue;
        } 

        var words = mem.split(line, " ");
        while (words.next()) |word| {
            var i: usize = 0;
            while (i < word.len) : (i += 1) {
                if (word[i] == ':') break;
            }

            const field = PassportField.fromString(word[0..i]);
            fields_found_map |= @enumToInt(field);

            const field_value = word[i + 1..word.len];
            const valid: bool = field.validate(field_value) catch false;
            fields_valid = fields_valid and valid;
        } 
    }

    return .{
        .naive = maybe_valid_passports, 
        .improved = valid_passports
    };
}


pub fn main() anyerror!void {
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var bytes: [MAX_FILE_SIZE]u8 = undefined;
    const length = try in.readAll(&bytes);
    
    var valid_count = countValidPass(bytes[0..length]);

    try stdout.print("{}\n", .{valid_count.naive});
    try stdout.print("{}\n", .{valid_count.improved});
}
