use std::{io, io::prelude::*};

#[derive(Debug)]
struct Line {
  command: String,
  value: i32,
}

fn main() -> io::Result<()> {
  // Parse
  let mut input = Vec::<Line>::new();

  for line in io::stdin().lock().lines() {
    let line = line?;
    let split = line.split_whitespace().collect::<Vec<&str>>();

    input.push(Line{
      command: split[0].to_string(),
      value: split[1].parse::<i32>().unwrap()
    })
  }

  //
  // Part 1
  //
  {
    let mut horizontal_position = 0;
    let mut depth = 0;

    for line in &input[..] {
      match line.command.as_ref() {
        "up" => depth -= line.value,
        "down" => depth += line.value,
        "forward" => horizontal_position += line.value,
        _ => horizontal_position += 0,
      }
    }
    println!("{}", horizontal_position * depth);
  }

  //
  // Part 2
  //
  {
    let mut horizontal_position = 0;
    let mut depth = 0;
    let mut aim = 0;

    for line in &input[..] {
      match line.command.as_ref() {
        "up" => aim -= line.value,
        "down" => aim += line.value,
        "forward" => {
          horizontal_position += line.value;
          depth += aim * line.value;
        },
        _ => horizontal_position += 0,
      }
    }
    println!("{}", horizontal_position * depth);
  }

  Ok(())
}
