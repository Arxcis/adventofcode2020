use std::{io, io::prelude::*};

fn main() {
  let stdin = io::stdin();
  let sum: i64 = stdin
    .lock()
    .lines()
    .filter_map(|line| line.ok()?.parse::<i64>().ok())
    .sum();

  println!("{}", sum);
}
