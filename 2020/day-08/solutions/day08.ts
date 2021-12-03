type Instruction = {
  op: "nop" | "acc" | "jmp";
  arg: number;
};

const input = (await Deno.readTextFile("/dev/stdin"))
  .split("\n")
  .slice(0, -1);

const instructions = input
  .map((line) => line.split(" "))
  .map(([op, arg]) => ({ op, arg: parseInt(arg) })) as Instruction[];

/** --- Part 1 --- */
{
  let ipTracker = new Set<number>([]);
  let accumulator = 0;
  let instructionPointer = 0;

  while (!ipTracker.has(instructionPointer)) {
    ipTracker.add(instructionPointer);

    const { op, arg } = instructions[instructionPointer];

    switch (op) {
      case "nop":
        instructionPointer += 1;
        break;
      case "acc":
        instructionPointer += 1;
        accumulator += arg;
        break;
      case "jmp":
        instructionPointer += arg;
        break;
    }
  }
  console.log(`${accumulator}`);
}

/** --- Part 2 --- */
{
  let ipTracker = new Set<number>([]);
  let accumulator = 0;
  let instructionPointer = 0;
  let modIndex = 0;

  for (
    let modStep = instructions.findIndex(({ op }) =>
      op === "nop" || op === "jmp"
    );
    modStep !== -1 && instructionPointer < instructions.length;
    modStep = instructions.slice(modIndex + 1).findIndex(({ op }) =>
      op === "nop" || op === "jmp"
    ), modIndex += 1 + modStep
  ) {
    ipTracker = new Set<number>([]);
    accumulator = 0;
    instructionPointer = 0;

    const { op: modOp, arg: modArg } = instructions[modIndex];

    const modifiedInstructions = [
      ...instructions.slice(0, modIndex),
      { arg: modArg, op: modOp === "nop" ? "jmp" : "nop" },
      ...instructions.slice(modIndex + 1),
    ];

    while (
      !ipTracker.has(instructionPointer) &&
      instructionPointer < instructions.length
    ) {
      ipTracker.add(instructionPointer);

      const { op, arg } = modifiedInstructions[instructionPointer];

      switch (op) {
        case "nop":
          instructionPointer += 1;
          break;
        case "acc":
          instructionPointer += 1;
          accumulator += arg;
          break;
        case "jmp":
          instructionPointer += arg;
          break;
      }
    }
  }

  console.log(`${accumulator}`);
}
