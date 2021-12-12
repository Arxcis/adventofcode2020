use std::{io, io::prelude::*};

// From: "x1,y1 -> x2,y2"
struct Entry {
    unique_signal_patterns: Vec<String>,
    four_digit_output_value: Vec<String>,
}

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut input = Vec::<Entry>::new();
    for line in io::stdin().lock().lines() {
        let line = line?;

        let split = line.split("|").collect::<Vec<&str>>();
        let (left,right) = (split[0].trim(), split[1].trim());
        let unique_signal_patterns = left.split(" ").map(|val|String::from(val)).collect::<Vec<String>>();
        let four_digit_output_value = right.split(" ").map(|val|String::from(val)).collect::<Vec<String>>();

        let entry = Entry{unique_signal_patterns,four_digit_output_value};
        input.push(entry);
    }
    //
    // Part 1
    //
    {
        let mut count: u64 = 0;
        for Entry{four_digit_output_value,..} in &input[..] {
            for value in four_digit_output_value {

                if value.len() == 2 // digit 1
                || value.len() == 3 // digit 7
                || value.len() == 4 // digit 4
                || value.len() == 7 // digit 8
                {
                    count += 1;
                }
            }
        }
        println!("{}", count);
    }

    Ok(())
}
