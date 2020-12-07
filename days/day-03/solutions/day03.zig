const std = @import("std");
const mem = std.mem;
const io = std.io;
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

const max_file_size = 20_000;

const Tile = enum {
    open,
    closed
};

const ParseError = error {
    UnrecognizedChar
};

// Zig will support support function definition expressions in 0.8
// see: https://github.com/ziglang/zig/issues/1717
inline fn parse(internal_map: *ArrayList(Tile), bytes: ArrayList(u8), pos: usize, exit_on_whitespace: bool) anyerror!usize {
    var i: usize = pos;
    
    parser: while (i < bytes.items.len) : (i += 1) {
        var tile: Tile = Tile.closed; 

        switch(bytes.items[i]) {
            '.' => tile = Tile.open,
            '#' => tile = Tile.closed,
            '\n', '\r' => if (exit_on_whitespace) break else continue :parser,
            else => return ParseError.UnrecognizedChar
        }

        try internal_map.append(tile);
    }

    return i;
}

const Map = struct {
    internal_map: ArrayList(Tile),
    map_width: usize,
    map_height: usize,

    pub inline fn fromBytesList(bytes: ArrayList(u8), pre_alloc: usize) anyerror!Map {
        var internal_map = try ArrayList(Tile).initCapacity(bytes.allocator, pre_alloc);
        var map_width: usize = 0;

        map_width = try parse(&internal_map, bytes, 0, true);
        _ = try parse(&internal_map, bytes, map_width, false);

        return Map {
            .internal_map = internal_map,
            .map_width = map_width,
            .map_height = @divFloor(internal_map.items.len, map_width)
        };
    }

    pub fn inspectPath(self: Map, right: usize, down: usize) u32 {
        var x_pos: usize = 0;
        var y_pos: usize = 0;

        var closed: u32 = 0;
        while (y_pos < self.map_height) {
            var wat = self.get(x_pos, y_pos);
            closed += @boolToInt(self.get(x_pos, y_pos) == Tile.closed);
            x_pos += right;
            y_pos += down;
        } 

        return closed;
    }

    pub fn get(self: Map, x: usize, y: usize) Tile {
        var real_x = x % self.map_width;
        var real_y = y * self.map_width;

        return self.internal_map.items[real_x + real_y];
    } 
};

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = &arena.allocator;

    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    // Lets not do io using the stack this time ... 
    comptime const pre_alloc = max_file_size * 0.8;
    var bytes = try ArrayList(u8).initCapacity(allocator, pre_alloc);
    try in.readAllArrayList(&bytes, max_file_size);

    var map = try Map.fromBytesList(bytes, pre_alloc);

    var path_3_1 = map.inspectPath(3, 1);
    try stdout.print("{}\n", .{path_3_1});

    try stdout.print("{}\n", .{map.inspectPath(1, 1) * path_3_1 * map.inspectPath(5, 1) * map.inspectPath(7, 1) * map.inspectPath(1, 2)});
}