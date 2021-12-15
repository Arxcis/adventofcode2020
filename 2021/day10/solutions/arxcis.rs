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
    {
        let mut stack = Vec::<char>::new();
        let mut points = 0;

        for line in lines.iter() {
            for current in line.chars() {
                match current {
                    '['|'('|'{'|'<' => stack.push(current),
                    ']'|')'|'}'|'>' => {
                        let prev = stack.pop().unwrap();
                        let mut syntax_error = '?';
                        match prev {
                            '(' if current != ')' => syntax_error = current,
                            '[' if current != ']' => syntax_error = current,
                            '{' if current != '}' => syntax_error = current,
                            '<' if current != '>' => syntax_error = current,
                            _ => (),
                        }
                        match syntax_error {
                            ')' => points += 3,
                            ']' => points += 57,
                            '}' => points += 1197,
                            '>' => points += 25137,
                            _ => (),
                        }
                    },
                    _ => panic!("ERROR uknown char: {}", current)
                }
            }
        }
        println!("{}", points);
    }

    Ok(())
}
