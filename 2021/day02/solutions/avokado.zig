const std = @import("std");
const Allocator = std.mem.Allocator;

const Unit = i32;

const Position = struct {
    horizontal: Unit = 0,
    depth: Unit = 0,
};

const ParseError = error {
    InvalidCharacter,
};

pub fn main() anyerror!void {
    const out = std.io.getStdOut().writer();

    var arena_alloc = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_alloc.deinit();

    var allocator = arena_alloc.allocator();

    const in_buffer = blk: {
        const std_in = std.io.getStdIn();
        const in_stat = try std_in.stat();
        break :blk try std_in.readToEndAllocOptions(
            allocator, 
            std.math.maxInt(usize), 
            in_stat.size, 
            @alignOf(u8), 
            null
        );
    };

    const p1 = try part1(in_buffer);
    try out.print("{d}\n", .{p1});
    
    const p2 = try part2(in_buffer);
    try out.print("{d}\n", .{p2});
}

inline fn part1(file_content: []const u8) !i32 {
    var position = Position{};

    var file_iter = std.mem.split(u8, file_content, "\n");
    while(file_iter.next()) |line| {
        if (line.len == 0) { continue; }

        switch (line[0]) {
            'f' => position.horizontal += try std.fmt.parseInt(Unit, line["forward ".len..], 10),
            'u' => position.depth -= try std.fmt.parseInt(Unit, line["up ".len..], 10),
            'd' => position.depth += try std.fmt.parseInt(Unit, line["down ".len..], 10),
            else => return ParseError.InvalidCharacter,
        }
    }
    return position.horizontal * position.depth;
}

inline fn part2(file_content: []const u8) !i32 {
    var position = Position{};
    var aim: Unit = 0;

    var file_iter = std.mem.split(u8, file_content, "\n");
    while(file_iter.next()) |line| {
        if (line.len == 0) { continue; }

        switch (line[0]) {
            'f' => {
                const delta = try std.fmt.parseInt(Unit, line["forward ".len..], 10);
                position.horizontal += delta;
                position.depth += aim * delta;
            },
            'u' => aim -= try std.fmt.parseInt(Unit, line["up ".len..], 10),
            'd' => aim += try std.fmt.parseInt(Unit, line["down ".len..], 10),
            else => return ParseError.InvalidCharacter,
        }
    }
    return position.horizontal * position.depth;
}

test "part1 example works" {
    const content = 
        \\forward 5
        \\down 5
        \\forward 8
        \\up 3
        \\down 8
        \\forward 2
    ;

    const result = try part1(content[0..]);
    try std.testing.expectEqual(@as(Unit, 150), result);
}

test "part2 example works" {
    const content = 
        \\forward 5
        \\down 5
        \\forward 8
        \\up 3
        \\down 8
        \\forward 2
    ;

    const result = try part2(content[0..]);
    try std.testing.expectEqual(@as(Unit, 900), result);
}
