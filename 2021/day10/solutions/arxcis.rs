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

    }
    Ok(())
}
