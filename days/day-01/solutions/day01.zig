const std = @import("std");
const mem = std.mem;
const io = std.io;
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

fn bytesToIntArrayList(allocator: *Allocator, bytes: []u8) !ArrayList(u32) {
    var list = try ArrayList(u32).initCapacity(allocator, 200);

    var it = mem.split(bytes, "\n");
    while (it.next()) |raw_line| {
        const line = mem.trim(u8, raw_line, &std.ascii.spaces);
        if (line.len == 0) continue; // empty line
        const value = try std.fmt.parseInt(u32, line, 10);
        try list.append(value);
    }

    return list;
}

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = &arena.allocator;

    const in = std.io.getStdIn().inStream();
    const stdout = std.io.getStdOut().writer();

    var buf: [2000]u8 = undefined;

    const length = try in.readAll(&buf);

    var input = try bytesToIntArrayList(allocator, buf[0..length]);

    // brute force solution as the byte parsing was enough of a challenge for now ...
    var part1: u32 = 0;
    var part2: u32 = 0;

    for (input.items) |leftSearchRoot, i| {
        var index = i + 1;
        while (index < input.items.len) : (index += 1) {
            var needle1 = input.items[index];
            if (leftSearchRoot + needle1 == 2020) {
                part1 = leftSearchRoot * needle1;
                break; // Assuming we can't have duplicates
            }

            var jndex = index + 1;
            while (jndex < input.items.len) : (jndex += 1) {
                var needle2 = input.items[jndex];
                if (leftSearchRoot + needle1 + needle2 == 2020) {
                    part2 = leftSearchRoot * needle1 * needle2;
                    break;
                }
            }
        }

        if (part1 > 0 and part2 > 0) {
            break;
        }
    }

    try stdout.print("{}\n", .{part1});
    try stdout.print("{}\n", .{part2});
}