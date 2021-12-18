use std::{io, io::prelude::*};


fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut lines = Vec::<String>::new();
    for line in io::stdin().lock().lines() {
        let line = line?;
        lines.push(String::from(line));
    }
    //
    // Part 1
    //
    let mut incomplete_lines = Vec::<String>::new();
    {
        let mut stack = Vec::<char>::new();
        let mut points = 0;

        for line in lines.iter() {
            let mut syntax_error = '?';
            for current in line.chars() {

                match current {
                    '['|'('|'{'|'<' => stack.push(current),
                    ']'|')'|'}'|'>' => {
                        let prev = stack.pop().unwrap();
                        match prev {
                            '(' if current != ')' => syntax_error = current,
                            '[' if current != ']' => syntax_error = current,
                            '{' if current != '}' => syntax_error = current,
                            '<' if current != '>' => syntax_error = current,
                            _ => (),
                        }
                    },
                    _ => panic!("ERROR uknown char: {}", current)
                }
                match syntax_error {
                    ')' => {points += 3; break;},
                    ']' => {points += 57; break;},
                    '}' => {points += 1197; break;},
                    '>' => {points += 25137; break;},
                    _ => (),
                }
            }
            if syntax_error == '?' {
                incomplete_lines.push(line.to_string());
            }
        }
        println!("{}", points);
    }
    //
    // Part 2
    //
    {
        let mut scores = Vec::<u64>::new();
        for line in incomplete_lines.iter() {

            let mut prev_stack = Vec::<char>::new();
           
            for it in line.chars() {
                match it {
                    '['|'('|'{'|'<' => prev_stack.push(it),
                    ']'|')'|'}'|'>' => { prev_stack.pop().unwrap(); },
                    _ => panic!("ERROR uknown char: {}", it),
                }
            }

            let mut missing_chars = Vec::<char>::new();
            for it in prev_stack {
                match it {
                    '[' => missing_chars.push(']'),
                    '{' => missing_chars.push('}'),
                    '(' => missing_chars.push(')'),
                    '<' => missing_chars.push('>'),
                    _ => panic!("ERROR uknown char: {}", it),
                }
            }

            let mut score = 0;
            while let Some(missing_char) = missing_chars.pop() {
                score *= 5;
                match missing_char {
                    ')' => score += 1,
                    ']' => score += 2,
                    '}' => score += 3,
                    '>' => score += 4,
                    _ => panic!("Error unknown missing char: {}", missing_char),
                }
            }
            scores.push(score);
        }
        scores.sort();

        let mid_score = scores[scores.len()/2];
        println!("{}", mid_score);
    }
    Ok(())
}
