const std = @import("std");
const mem = std.mem;
const io = std.io;
const ArrayList = std.ArrayList;

const MAX_FILE_SIZE = 20_000;

const Map = struct {
    bytes: []u8,
    line_width: usize,
    map_height: usize,

    pub inline fn init(bytes: []u8) Map {
        var line_width: usize = 0;
        while (line_width < bytes.len) : (line_width += 1) {
            switch(bytes[line_width]) {
                '\n', '\r' => break,
                else => continue
            }
        }

        line_width += 1;

        return Map {
            .bytes = bytes,
            .line_width = line_width,  // TODO: account for arbitrary line ending format
            .map_height = @divFloor(bytes.len, line_width)
        };
    } 

    pub inline fn inspectPath(self: Map, rigth: usize, down: usize) usize {
        var x_pos: usize = 0;
        var y_pos: usize = 0;
        var closed: u32 = 0;

        while (y_pos < self.map_height) {
            var n_skipped = @divFloor(x_pos, self.line_width - 1);
            var real_x = (x_pos + n_skipped) % self.line_width;
            var real_y = y_pos * self.line_width;

            closed += @boolToInt(self.bytes[real_x + real_y] == '#');

            x_pos += rigth;
            y_pos += down;
        }

        return closed;
    }
};



pub fn main() anyerror!void {
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [MAX_FILE_SIZE]u8 = undefined;
    const length = try in.readAll(&buf);

    var map = Map.init(buf[0..length]);

    var path_3_1 = map.inspectPath(3, 1);
    try stdout.print("{}\n", .{path_3_1});

    try stdout.print("{}\n", .{map.inspectPath(1, 1) * path_3_1 * map.inspectPath(5, 1) * map.inspectPath(7, 1) * map.inspectPath(1, 2)});
}
