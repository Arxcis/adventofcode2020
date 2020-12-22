const std = @import("std");
const mem = std.mem;
const io = std.io;
const d_print = std.debug.print;

const MAX_FILE_SIZE = 20_000;
const MAX_INSTRUCTIONS = 2000;

const CompileError = error {
    invalidInstruction,
};

const RuntimeError = error {
    infinite,
    failedToRepair,
};

const Instruction = union(enum) {
    acc: i16,
    jmp: i16,
    nop: i16,
};

const Singularity = struct {
    const Self = @This();

    accumulator: i16,
    instructions: [MAX_INSTRUCTIONS]Instruction,
    ptr: usize,
    length: usize,

    executed: [MAX_INSTRUCTIONS]usize,
    e_index: usize,

    repair_contenders: [MAX_INSTRUCTIONS]usize,
    r_length: usize,
    r_index: usize,

    inline fn init() Self {
        return Self {
            .accumulator = 0,
            .instructions = undefined,
            .ptr = 0,
            .length = 0,
            .executed = undefined,
            .e_index = 0,
            .repair_contenders = undefined,
            .r_length = 0,
            .r_index = 0,
        };
    }

    // TODO: interperet would be faster, but also a hell to handle the byte buffer
    inline fn compile_line(self: *Self, line: []const u8) !void {
        if (line.len == 0) return;

        const instr = line[0..3];
        const value = try std.fmt.parseInt(i16, line[4..], 10);
        const parsed: Instruction = blk: {
            if (mem.eql(u8, instr, "acc")) {
                break :blk Instruction { .acc = value };
            } else if (mem.eql(u8, instr, "jmp")) {
                break :blk Instruction { .jmp = value };
            } else if (mem.eql(u8, instr, "nop")) {
                break :blk Instruction { .nop = value };
            } else {
                return CompileError.invalidInstruction;
            }
        };

        self.instructions[self.length] = parsed;
        self.length += 1;
    }

    inline fn exec_next(self: *Self) !bool {
        {
            var i: usize = 0;
            while (i < self.e_index) : (i += 1) {
                if (self.executed[i] == self.ptr) return RuntimeError.infinite; 
            }
        }

        if (self.ptr >= self.length) return false;
        
        const ptr_mov = switch (self.instructions[self.ptr]) {
            .acc => |amount| blk: { 
                self.accumulator += amount; 
                break :blk 1;
            },
            .jmp => |stride| blk: {
                self.repair_contenders[self.r_length] = self.ptr;
                self.r_length += 1;
                break :blk stride;
            },
            .nop => blk: {
                self.repair_contenders[self.r_length] = self.ptr;
                self.r_length += 1;
                break :blk 1;
            },
        };

        self.executed[self.e_index] = self.ptr;
        self.e_index += 1;

        self.ptr = @intCast(usize, (@intCast(i16, self.ptr) + ptr_mov));

        return true;
    }

    inline fn flip_instruction(self: *Self, index: usize) void {
        switch (self.instructions[index]) {
            .jmp => |v| self.instructions[index] = Instruction { .nop = v },
            .nop => |v| self.instructions[index] = Instruction { .jmp = v },
            else => {},
        }
    }

    inline fn repair(self: *Self) !void {
        // brute force because this code is already enough spaghetti 
        while (true) {
            if (self.exec_next()) |is_not_complete| {
                if (!is_not_complete) break; 
            } else |err| {
                if (self.r_index < self.r_length) {
                    if (self.r_index > 0) self.flip_instruction(self.repair_contenders[self.r_index-1]);
                    self.flip_instruction(self.repair_contenders[self.r_index]);
                    self.r_index += 1;
                    self.restart();
                } else {
                    return RuntimeError.failedToRepair;
                }
            }
        }
    }

    inline fn restart(self: *Self) void {
        self.accumulator = 0;
        self.ptr = 0;
        self.e_index = 0;
        self.executed = undefined;
    }
};

pub fn main() anyerror!void {
    const in = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var bytes: [MAX_FILE_SIZE]u8 = undefined;
    const length = try in.readAll(&bytes);
    var singularity = Singularity.init();

    var it = mem.split(bytes[0..length], "\n");
    while (it.next()) |line| {
        try singularity.compile_line(line);
    }

    while (singularity.exec_next() catch false) {
        continue;
    }
    const part1 = singularity.accumulator;
    try singularity.repair();

    try stdout.print("{}\n{}\n", .{part1, singularity.accumulator});
}
