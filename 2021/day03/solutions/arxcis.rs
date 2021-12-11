use std::{io, io::prelude::*};

const ZERO_BYTE: u8 = 48;
const ONE_BYTE: u8 = 49;

fn main() -> io::Result<()> {
  //
  // Parse
  //
  let mut input = Vec::<String>::new();
  for line in io::stdin().lock().lines() {
    input.push(line?);
  }
  //
  // Measure most common bit for each column
  //
  let compute_weights = |input: &[String]| {
    let mut weights = Vec::<i32>::new();

    for _ in input[0].as_bytes() {
      weights.push(0)
    }

    for line in &input[..] {
      let bytes = line.as_bytes();

      for i in 0..bytes.len() {
        let byte = bytes[i];

        match byte {
          ZERO_BYTE => weights[i] -= 1, // Decrement weight for each 0 byte
          ONE_BYTE => weights[i] += 1,  // Increment weight for each 1 byte
          _ => (),
        };
      }
    }

    weights
  };

  let weights = compute_weights(&input);

  //
  // Part 1
  //
  {
    let mut gamma_rate = 0b0000_0000;
    let mut epsilon_rate = 0b0000_0000;

    for i in 0..weights.len() {
      let j = weights.len()-1 - i;
      let weight = weights[i];

      // If weight is negative, most common bit for this column was 0
      if weight < 0 {
        epsilon_rate |= 1 << j;
      }
      // If weight is positive, most common bit for this columnn was 1
      else { // if weight > 0 {
        gamma_rate |= 1 << j;
      }
    }
    let consumption = epsilon_rate * gamma_rate;
    println!("{}", consumption);
  }
  //
  // Part 2 - oxygen_generator_rating
  //
  {
    let compute_weight = |i: usize, input: &[String]| {
      let mut weight: i32 = 0;

      for line in &input[..] {
        let byte = line.as_bytes()[i];

        match byte {
          ZERO_BYTE => weight -= 1, // Decrement weight for each 0 byte
          ONE_BYTE => weight += 1,  // Increment weight for each 1 byte
          _ => (),
        };
      }

      weight
    };

    let mut selection = input.clone();

    for i in 0..weights.len() {
      let weight = compute_weight(i, &selection);

      if weight >= 0 {
        // 1's most common, or equal, keep 1's
        selection = selection.iter()
          .filter(|item| (item.as_bytes()[i]) == ONE_BYTE)
          .map(|item| String::from(item))
          .collect();
      } else { // if weight < 0
        // 0's most common, keep 0's
        selection = selection.iter()
          .filter(|item| (item.as_bytes()[i]) == ZERO_BYTE)
          .map(|item| String::from(item))
          .collect();
      }
      if selection.len() == 1 {
        break;
      }
    }
    let oxygen_generator_rating_str = &selection[0];
    let oxygen_generator_rating = u32::from_str_radix(oxygen_generator_rating_str, 2).unwrap();

    let mut selection = input.clone();

    for i in 0..weights.len() {
      let weight = compute_weight(i, &selection);

      if weight >= 0 {
        // 1's most common, or equal, keep 0's
        selection = selection.iter()
          .filter(|item| (item.as_bytes()[i]) == ZERO_BYTE)
          .map(|item| String::from(item))
          .collect();
      } else { // if weight < 0
        // 0's most common, keep 1's
        selection = selection.iter()
          .filter(|item| (item.as_bytes()[i]) == ONE_BYTE)
          .map(|item| String::from(item))
          .collect();
      }
      if selection.len() == 1 {
        break;
      }
    }
    let co2_scrubber_rating_str = &selection[0];
    let co2_scrubber_rating = u32::from_str_radix(co2_scrubber_rating_str, 2).unwrap();

    println!("{}", oxygen_generator_rating * co2_scrubber_rating);
  }
  Ok(())
}
