use std::{io, io::prelude::*};

fn main() -> io::Result<()> {
  let mut input = Vec::new();

  for line in io::stdin().lock().lines() {
    let num = line.unwrap().parse::<i32>().unwrap();
    input.push(num)
  }

  // Part 1
  let mut right_is_larger_count: i32 = 0;

  for i in 0..input.len() - 1 {
    let left = input[i];
    let right = input[i+1];

    right_is_larger_count += (left < right) as i32;
  }
  println!("{}", right_is_larger_count);

  // Part 2
  right_is_larger_count = 0;
  for i in 0..input.len() - 3 {
    let one = input[i];
    let two = input[i+1];
    let three = input[i+2];
    let four = input[i+3];

    let left = one + two + three;
    let right = two + three + four;

    right_is_larger_count += (left < right) as i32;
  }
  println!("{}", right_is_larger_count);

  Ok(())
}
