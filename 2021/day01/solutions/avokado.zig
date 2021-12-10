const std = @import("std");
const Allocator = std.mem.Allocator;

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

fn part1(file_content: []const u8) !u32 {
    var incr_count: u32 = 0;
    var prev_value: u32 = std.math.maxInt(u32);

    var file_iter = std.mem.split(u8, file_content, "\n");
    while(file_iter.next()) |line| {
        if (line.len == 0) { continue; }

        const new_value = try std.fmt.parseUnsigned(u32, line, 10);
        if(new_value >= prev_value) {
            incr_count += 1;
        }
        prev_value = new_value;
    }
    return incr_count;
}

const Window = @Vector(3, i32);

fn part2(file_content: []const u8) !u32 {
    var incr_count: u32 = 0;
    var file_iter = std.mem.split(u8, file_content, "\n");

    var window_buf: [4]i32 = undefined;

    {   
        var i: u8 = 0;
        while(file_iter.next()) |line| {
            if (line.len == 0) { continue; }
            window_buf[i] = try std.fmt.parseInt(i32, line, 10);
            
            if (i == 2) break;
            i += 1;
        }
    }

    while(file_iter.next()) |line| {
        if (line.len == 0) { continue; }

        window_buf[3] = try std.fmt.parseInt(i32, line, 10);
        // SIMD arithmetic
        const a: Window = window_buf[0..3].*;
        const b: Window = window_buf[1..4].*;

        if (0 > @reduce(.Add, a - b)) {
            incr_count += 1;
        }

        window_buf[0] = window_buf[1];
        window_buf[1] = window_buf[2];
        window_buf[2] = window_buf[3];
    }
    return incr_count;
}


test "part1 example works" {
    // make sure newline does not correspond to CRLF here to avoid compiler errors
    const content = 
    \\199
    \\200
    \\208
    \\210
    \\200
    \\207
    \\240
    \\269
    \\260
    \\263
    ;

    const result = try part1(content[0..]);
    try std.testing.expectEqual(@as(u32, 7), result);
}

test "part2 example works" {
    // make sure newline does not correspond to CRLF here to avoid compiler errors
    const content = 
    \\199
    \\200
    \\208
    \\210
    \\200
    \\207
    \\240
    \\269
    \\260
    \\263
    ;

    const result = try part2(content[0..]);
    try std.testing.expectEqual(@as(u32, 5), result);
}
