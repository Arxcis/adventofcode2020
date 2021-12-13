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
    //
    // Part 2
    //
    {
        let mut four_digits_sum: u64 = 0;
        for Entry{unique_signal_patterns, four_digit_output_value} in &input[..] {

            
            let mut patterns = Vec::<u8>::new();

            for pattern_str in unique_signal_patterns.iter() {

                let mut pattern: u8 = 0b0000_0000;

                for ch in pattern_str.chars() {
                    match ch {
                        'a' => pattern |= 0b0100_0000,
                        'b' => pattern |= 0b0010_0000,
                        'c' => pattern |= 0b0001_0000,
                        'd' => pattern |= 0b0000_1000,
                        'e' => pattern |= 0b0000_0100,
                        'f' => pattern |= 0b0000_0010,
                        'g' => pattern |= 0b0000_0001,
                        _ => println!("error: unknown ch: {}", ch),
                    } 
                }
                patterns.push(pattern);
            }
            
            let mut one: u8 = 0;
            let mut four: u8 = 0;
            let mut seven: u8 = 0;
            let mut eight: u8 = 0;
            let mut fivers = Vec::<u8>::new();
            let mut sixers = Vec::<u8>::new();

            for pattern in patterns {
                if pattern.count_ones() == 2 {
                    one = pattern;
                } else
                if pattern.count_ones() == 4 {
                    four = pattern;
                } else
                if pattern.count_ones() == 3 {
                    seven = pattern;
                } else
                if pattern.count_ones() == 7 {
                    eight = pattern;
                } else
                if pattern.count_ones() == 5 {
                    fivers.push(pattern);
                } else
                if pattern.count_ones() == 6 {
                    sixers.push(pattern);
                } else {
                    panic!("Error pattern.len(): {}, pattern: {}", pattern.count_ones(), pattern);
                }
            }
            
            // six = "the sixer which does not contain one"
            let six = sixers.iter().find(|&&it| it & one != one).unwrap();
  
            // three = "the fiver which does contain one"
            let three = fivers.iter().find(|&&it| it & one == one).unwrap();

            // nine = "the sixer which contains four"
            let nine = sixers.iter().find(|&&it| it & four == four).unwrap();

            // not_threes = ""
            let not_threes = fivers.iter().filter(|&&it| it & *three != *three).collect::<Vec<&u8>>();
 
            // five = "the not-threer which sixers contain"
            let five = not_threes.iter().find(|&&it| 
                                             sixers.iter().find(|&&ot|
                                                                ot & *it == *it) != None).unwrap();
            // two = "not five in not_threes"
            let two = not_threes.iter().find(|&&it| it & **five != **five).unwrap();

            // zero = "the sixer NOT containing five"
            let zero = sixers.iter().find(|&&it| it & **five != **five).unwrap();


            let mut four_digits = String::from("");

            for value_str in four_digit_output_value {
                let mut value: u8 = 0b0000_0000;

                for ch in value_str.chars() {
                    match ch {
                        'a' => value |= 0b0100_0000,
                        'b' => value |= 0b0010_0000,
                        'c' => value |= 0b0001_0000,
                        'd' => value |= 0b0000_1000,
                        'e' => value |= 0b0000_0100,
                        'f' => value |= 0b0000_0010,
                        'g' => value |= 0b0000_0001,
                        _ => println!("error: unknown ch: {}", ch),
                    } 
                }
                match value {
                    x if x == one => four_digits.push_str("1"),
                    x if x == **two => four_digits.push_str("2"),
                    x if x == *three => four_digits.push_str("3"),
                    x if x == four => four_digits.push_str("4"),
                    x if x == **five => four_digits.push_str("5"),
                    x if x == *six => four_digits.push_str("6"),
                    x if x == seven => four_digits.push_str("7"),
                    x if x == eight => four_digits.push_str("8"),
                    x if x == *nine => four_digits.push_str("9"),
                    x if x == *zero => four_digits.push_str("0"),
                    _ => println!("error: unknown value: {}", value),
                }
            }
            let four_digits: u64 = four_digits.parse().unwrap();
            four_digits_sum += four_digits;
             
        }

        println!("{}",four_digits_sum);
    }

    Ok(())
}

