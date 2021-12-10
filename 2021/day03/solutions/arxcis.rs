use std::{io, io::prelude::*};

fn main() -> io::Result<()> {
  //
  // Parse
  //
  let mut input = Vec::<String>::new();
  for line in io::stdin().lock().lines() {
    input.push(line?);
  }
  //
  // Part 1
  //
  let mut counters = Vec::<i32>::new();
  for _ in input[0].as_bytes() {
    counters.push(0)
  }

  for bits in &input[..] {
    let bits = bits.as_bytes();

    for i in 0..bits.len() {
      let bit = bits[i];

      match bit {
        48 => counters[i] -= 1, // 0b0
        49 => counters[i] += 1, // 0b1
        _ => (),
      };
    }
  }
  let mut gamma_rate = 0b0000_0000;
  let mut epsilon_rate = 0b0000_0000;

  for i in 0..counters.len() {
    let j = counters.len()-1 - i;
    let count = counters[i];

    if count < 0 {
      epsilon_rate |= 1 << j;
    }
    else if count > 0 {
      gamma_rate |= 1 << j;
    }
  }
  let consumption = epsilon_rate * gamma_rate;
  println!("{}", consumption);

  //
  // Part 2
  //
  Ok(())
}
