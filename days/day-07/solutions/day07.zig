const std = @import("std");
const mem = std.mem;
const io = std.io;

const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const MAX_LINE_SIZE = 250; 
const MAX_RECURSION_DEPTH = 10;
const NEEDLE: []const u8 = "shiny gold";


const ReadError = error {
    LineEnding
};

const BagEntry = struct {
    identifier: []const u8,
    quantity: usize,

    inline fn init(identifier: []const u8, quantity: usize) BagEntry {
        return BagEntry {
            .identifier = identifier,
            .quantity = quantity,
        };
    }
};
const BagHashMap = std.StringHashMap(ArrayList(BagEntry));
const TakenMap = std.StringHashMap(bool);

inline fn readBagId(comptime firstId: bool, allocator: *Allocator, line_slice: []const u8, pos: *usize) ![]const u8 {
    while (pos.* < line_slice.len and line_slice[pos.*] == ' ') : (pos.* += 1) {
        continue;
    }
    
    const start_pos = pos.*;
    while (pos.* < line_slice.len) : (pos.* += 1) {
        if (mem.eql(u8, line_slice[pos.*..pos.* + 4], " bag")) {
            const dest_ptr: []u8 = try allocator.alloc(u8, pos.* - start_pos);
            mem.copy(u8, dest_ptr, line_slice[start_pos..pos.*]);

            if (firstId) {
                pos.* += 14; // skip " bags contain "
            } else {
                // if not at line ending, move cursor
                if (pos.* + 5 < line_slice.len) { 
                    // skip " bags, " or " bags."
                    pos.* += 6 + @as(usize, @boolToInt(line_slice[pos.* + 5] == ','));
                }
            }

            
            return dest_ptr;
        }
    }

    return ReadError.LineEnding;
}

// TODO: tail recursion
fn part1(part1_map: BagHashMap, needle: []const u8, depth: usize, takenIds: *TakenMap) usize {
    const needle_parents = part1_map.get(needle) orelse unreachable;
    if (needle_parents.items.len <= 0 or depth >= MAX_RECURSION_DEPTH) return 0;
    
    var parent_count: usize = 0;
    for (needle_parents.items) |parent| {
        if (takenIds.contains(parent.identifier)) continue;

        parent_count += part1(part1_map, parent.identifier, depth + 1, takenIds) + 1;
        takenIds.put(parent.identifier, true) catch unreachable;
    } 

    return parent_count;
}

fn part2(part2_map: BagHashMap, needle: []const u8, depth: usize) usize {
    const needle_children = part2_map.get(needle) orelse unreachable;
    if (needle_children.items.len <= 0 or depth >= MAX_RECURSION_DEPTH) return 0;

    var accumulative_quantity: usize = 0;
    for (needle_children.items) |child| {
        accumulative_quantity += child.quantity + child.quantity * part2(part2_map, child.identifier, depth + 1);
    }

    return accumulative_quantity;
}

fn insertNewEntry(allocator: *Allocator, map: *BagHashMap, key: []const u8, entry: BagEntry,) !void {
    if (map.contains(key)) {
        var bag_parents = map.get(key) orelse unreachable;
        try bag_parents.append(entry);
        try map.put(key, bag_parents);
    } else {
        var bag_parents = try ArrayList(BagEntry).initCapacity(allocator, 8);
        try bag_parents.append(entry);
        try map.putNoClobber(key, bag_parents);
    }
}

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;
    
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    const stderr = std.io.getStdErr().writer();

    var line_buffer: [MAX_LINE_SIZE]u8 = undefined;

    var part1_map = BagHashMap.init(allocator);
    var part2_map = BagHashMap.init(allocator);
    
    while (in.readUntilDelimiterOrEof(line_buffer[0..], '\n')) |maybe_line| {
        const raw_line = maybe_line orelse break;
        const line = mem.trim(u8, raw_line, &std.ascii.spaces);
        if (line.len == 0) continue; // empty line

        var cursor_pos: usize = 0;
        if (readBagId(true, allocator, line, &cursor_pos)) |bagId| {
            if (!part1_map.contains(bagId)) {
                var bag_parents = try ArrayList(BagEntry).initCapacity(allocator, 8);
                try part1_map.put(bagId, bag_parents);
            }

            if (!part2_map.contains(bagId)) {
                var bag_parents = try ArrayList(BagEntry).initCapacity(allocator, 8);
                try part2_map.put(bagId, bag_parents);
            }

            line: while (cursor_pos < line.len) {
                const quantity_start = cursor_pos;
                while (cursor_pos < line.len and line[cursor_pos] != ' ') : (cursor_pos += 1) {
                    continue;
                }
                if (cursor_pos == line.len) continue;

                const quantity = std.fmt.parseInt(usize, line[quantity_start..cursor_pos], 10) catch break :line;
                const bagContentId = try readBagId(false, allocator, line, &cursor_pos);
                
                { // part 1 map 
                    const entry = BagEntry.init(bagId, quantity);
                    try insertNewEntry(allocator, &part1_map, bagContentId, entry);
                }
                { // part 2 map
                    const entry = BagEntry.init(bagContentId, quantity);
                    try insertNewEntry(allocator, &part2_map, bagId, entry);
                }
               
            }
        } else |err| {
            switch(err) {
                error.LineEnding => continue,
                error.OutOfMemory => @panic("out of memory!"),
            }
        }
    } else |err| {
        switch(err) {
            error.StreamTooLong => try stderr.print("buffer smaller than line length", .{}),
            else => try stderr.print("fs error", .{}),
        }
    }

    var takenBagIds = TakenMap.init(allocator);
    const part1_answer = part1(part1_map, NEEDLE, 0, &takenBagIds);
    const part2_answer = part2(part2_map, NEEDLE, 0);

    try stdout.print("{}\n{}\n", .{part1_answer, part2_answer});
}
