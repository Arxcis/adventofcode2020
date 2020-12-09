const std = @import("std");
const mem = std.mem;
const io = std.io;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const MAX_FILE_SIZE = 15_000; 

fn LineSegmentParser(comptime low_char: u8, comptime high_char: u8, comptime start_max: f32) type {
    return struct {
        fn parse(line: []const u8, from: usize, to: usize) u32 {
            var prev: f32 = 0;
            var min: f32 = 0;
            var max: f32 = start_max;
            var i: usize = from;
        
            while (i < to) : (i += 1) {
                const is_not_last: bool = to - i > 1;

                var delta: f32 = if (is_not_last) @ceil((max - min) / 2.0) else 0;

                switch (line[i]) {
                    low_char =>  {
                        max -= delta;
                        prev = min;
                    },
                    high_char => {
                        min += delta;
                        prev = max;
                    },
                    else => unreachable // TODO: error
                } 

            }

            return @floatToInt(u32, prev);
        }
    };
}

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;
    
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var bytes: [MAX_FILE_SIZE]u8 = undefined;
    const length = try in.readAll(&bytes);

    comptime const row_extractor = LineSegmentParser('F', 'B', 127);
    comptime const col_extractor = LineSegmentParser('L', 'R', 7);
    
    var list = try ArrayList(u32).initCapacity(allocator, 1000);
    try list.append(0);
    defer list.deinit();

    var highest_id: u32 = 0;
    var it = mem.split(bytes[0..length], "\n");
    while (it.next()) |raw_line| {
        const line = mem.trim(u8, raw_line, &std.ascii.spaces);
        if (line.len == 0) continue; // empty line
        
        const row_start: usize = line.len - 3;
        const row = row_extractor.parse(line, 0, row_start);
        const col = col_extractor.parse(line, row_start, line.len);

        const id: u32 = row * 8 + col;
        if (id > highest_id) highest_id = id;

        // build sorted list
        var i: usize = list.items.len - 1;
        while (i >= 0) : (i -= 1) {
            if (id > list.items[i]) {
                try list.insert(i + 1, id);
                break;
            }
        }
    }

    var i: usize = 1;
    var prev_id: u32 = 0;
    var my_id: u32 = 0;
    while (i < list.items.len) : (i += 1) {
        if (list.items[i + 1] - list.items[i] == 2) {
            my_id = list.items[i] + 1;
            break;
        }

        prev_id = list.items[i];
    }

    try stdout.print("{}\n{}\n", .{highest_id, my_id});
}
