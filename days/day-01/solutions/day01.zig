const std = @import("std");
const io = std.io;
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

 // TODO: find std function to do this for me :(
fn bytesToIntArrayList(allocator: *Allocator, bytes: []u8, length: usize) anyerror!ArrayList(u32) {
    var list = ArrayList(u32).init(allocator);
    try list.ensureCapacity(200);

    var i: usize = 0;
    var stride: usize = 0;
    while  (i < length) : (i += stride + 2) {
        var j: usize = 0;
        stride = 0;

        while (j < bytes.len and bytes[i + j] != '\n') : (j += 1) {
            stride = j;
        }
        
        if (std.fmt.parseInt(u32, bytes[i..i+stride], 10)) |value| {
            // TODO: handle this instead.
            try list.append(value);
        } else |err| {
            std.debug.warn("failed to parse int. error: {}, i: {}, stride: {}, slice content: {}", .{err, i, stride, bytes[i..i+stride]});
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

    var buf: [2000]u8 = undefined;

    const length = try in.readAll(&buf);

    var input = try bytesToIntArrayList(allocator, &buf, length);

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

    try stdout.print("{}\r\n", .{part1});
    try stdout.print("{}\r\n", .{part2});
}