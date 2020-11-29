use std::{io, io::prelude::*};

fn main() {
  let stdin = io::stdin();
  let (sum_all, sum_odd) = stdin
    .lock()
    .lines()
    .filter_map(|line| line.ok())
    .filter_map(|line| line.parse::<i64>().ok())
    .fold((0, 0), 
      |(sum_all, sum_odd), num| 
      (
        sum_all + num, 
        sum_odd + if num % 2 != 0 { num } else { 0 }
      )
    );

  println!("{}", sum_all);
  println!("{}", sum_odd);
}
