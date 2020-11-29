use std::{io, io::prelude::*};

fn main() {
  let stdin = io::stdin();
  let sum = stdin
    .lock()
    .lines()
    .filter_map(|line| line.ok()?.parse::<i64>().ok())
    .fold(0, |acc, number| acc + number);

  println!("{}", sum);
}
