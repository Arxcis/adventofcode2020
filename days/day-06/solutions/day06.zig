const std = @import("std");
const mem = std.mem;
const io = std.io;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const MAX_FILE_SIZE = 20_000;

const ParseError = error {
    UnrecognizedChar
};

inline fn charToBitMapElement(char: u8) ParseError!u32 {
    switch (char) {
        'a' => return 1<<0,
        'b' => return 1<<1,
        'c' => return 1<<2,
        'd' => return 1<<3,
        'e' => return 1<<4,
        'f' => return 1<<5,
        'g' => return 1<<6,
        'h' => return 1<<7,
        'i' => return 1<<8,
        'j' => return 1<<9,
        'k' => return 1<<10,
        'l' => return 1<<11,
        'm' => return 1<<12,
        'n' => return 1<<13,
        'o' => return 1<<14,
        'p' => return 1<<15,
        'q' => return 1<<16,
        'r' => return 1<<17,
        's' => return 1<<18,
        't' => return 1<<19,
        'u' => return 1<<20,
        'v' => return 1<<21,
        'w' => return 1<<22,
        'x' => return 1<<23,
        'y' => return 1<<24,
        'z' => return 1<<25,
        else => return ParseError.UnrecognizedChar
    }
}

inline fn countBits(bits: u32) u32 {
    var mut_bits = bits;
    var bit_count: u32 = 0;
    while (mut_bits > 0) {
        bit_count += mut_bits & 1;
        mut_bits = mut_bits >> 1; 
    }

    return bit_count;
}

pub fn main() anyerror!void {
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var bytes: [MAX_FILE_SIZE]u8 = undefined;
    const length = try in.readAll(&bytes);

    var yes_count: u32 = 0;
    var uniform_yes_count: u32 = 0;

    var it = mem.split(bytes[0..length], "\n\n");
    var mytest: u8 = 0;
    while (it.next()) |raw_lines| {
        const group = mem.trim(u8, raw_lines, &std.ascii.spaces);

        var answer_map: u32 = 0;
        var i: u8 = 0;
        while (i < group.len) : (i += 1) {
            if (group[i] == '\n') break;
            answer_map |= try charToBitMapElement(group[i]);
        }

        var uniform_answer_map: u32 = answer_map;
        var line_map: u32 = answer_map;
        while (i < group.len) : (i += 1) {
            if (group[i] == '\n') {
                uniform_answer_map &= line_map;
                line_map = 0;
                continue;
            }

            line_map |= try charToBitMapElement(group[i]);
            answer_map |= line_map;
        }

        yes_count += countBits(answer_map);
        uniform_yes_count += countBits(uniform_answer_map & line_map);
    }

    try stdout.print("{}\n{}\n", .{yes_count, uniform_yes_count});
}
