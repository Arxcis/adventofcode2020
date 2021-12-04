use std::{io, io::prelude::*};

fn main() {
  let stdin = io::stdin();
  let lines = stdin.lock().lines().filter_map(|line| line.ok()?.parse::<i64>().ok()).collect::<Vec<i64>>();
  let lines = &lines;

  let triplets = lines.iter().cloned().flat_map(|i|
      lines.iter().cloned().flat_map(move |j|
        lines.iter().copied().map(move |k| (i, j, k)))).collect::<Vec<(i64,i64,i64)>>();
  let triplets = &triplets;

  let part1 = triplets.iter().find_map(|(i,j,_k)| if i+j == 2020 { Some(i*j) } else { None } );
  let part2 = triplets.iter().find_map(|(i,j,k)| if i+j+k == 2020 { Some(i*j*k) } else { None } );

  println!("{}", part1.unwrap_or_default());
  println!("{}", part2.unwrap_or_default());
}
