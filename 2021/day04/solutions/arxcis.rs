use std::{io, cmp, io::prelude::*};
use std::collections::HashSet;
use std::iter::FromIterator;

fn main() -> io::Result<()> {
    let mut input = Vec::<String>::new();
    for line in io::stdin().lock().lines() {
        input.push(line?);
    }
    //
    // Part 0 - Parse bingo boards and numbers
    //
    let numbers: Vec<u8> = input[0].split(",").map(|val| val.parse().unwrap()).collect();
    let mut boards = Vec::<Vec::<Vec::<u8>>>::new();

    for i in (2..input.len()).step_by(6) {

        let _b: Vec<u8> = input[i+0].trim().replace("  ", " ").split(" ").map(|val|val.parse().unwrap()).collect();
        let _i: Vec<u8> = input[i+1].trim().replace("  ", " ").split(" ").map(|val|val.parse().unwrap()).collect();
        let _n: Vec<u8> = input[i+2].trim().replace("  ", " ").split(" ").map(|val|val.parse().unwrap()).collect();
        let _g: Vec<u8> = input[i+3].trim().replace("  ", " ").split(" ").map(|val|val.parse().unwrap()).collect();
        let _o: Vec<u8> = input[i+4].trim().replace("  ", " ").split(" ").map(|val|val.parse().unwrap()).collect();

        let b: Vec<u8> = vec![_b[0],_i[0],_n[0],_g[0],_o[0]];
        let i: Vec<u8> = vec![_b[1],_i[1],_n[1],_g[1],_o[1]];
        let n: Vec<u8> = vec![_b[2],_i[2],_n[2],_g[2],_o[2]];
        let g: Vec<u8> = vec![_b[3],_i[3],_n[3],_g[3],_o[3]];
        let o: Vec<u8> = vec![_b[4],_i[4],_n[4],_g[4],_o[4]];

        let board = vec![_b,_i,_n,_g,_o,b,i,n,g,o];

        boards.push(board);
    }
    //
    // Part 1
    //
    {
        let mut winning_board = Vec::<Vec::<u8>>::new();
        let mut min_board_attempts = 255;

        for board in &boards[..] {
            let mut min_line_attempts = 255;

            for line in &board[..] {
                let mut max_cell_attempts = 0;

                for cell in &line[..] {
                    let mut attempts = 0;

                    for num in &numbers[..] {
                        attempts += 1;
                        if num == cell {
                            break;
                        }
                    }
                    max_cell_attempts = cmp::max(attempts, max_cell_attempts);
                }
                min_line_attempts = cmp::min(max_cell_attempts, min_line_attempts);
            }
 
            if min_line_attempts < min_board_attempts {
                winning_board = board.to_vec();
                min_board_attempts = min_line_attempts;
            }
        }
        let winning_number = u64::from(numbers[min_board_attempts-1]);

        let winning_board: HashSet<u64> = HashSet::from_iter(
            winning_board.iter()
                .flatten()
                .map(|num| u64::from(*num))
                .collect::<Vec<u64>>()
                .iter()
                .cloned()
        );

        let said_numbers: Vec<u64> = numbers.iter()
            .take(min_board_attempts)
            .map(|num| u64::from(*num))
            .collect();

        let marked_numbers: Vec<&u64> = winning_board.iter()
            .filter(|number| said_numbers.contains(number))
            .collect();

        let unmarked_numbers: Vec<u64> = winning_board.iter()
            .filter(|number| !marked_numbers.contains(number))
            .map(|num| u64::from(*num))
            .collect();

        let unmarked_sum: u64 = unmarked_numbers.iter().sum();
        println!("{}", winning_number * unmarked_sum);
    }
    //
    // Part 2 
    //
    {
        let mut winning_board = Vec::<Vec::<u8>>::new();
        let mut max_board_attempts = 0;

        for board in &boards[..] {
            let mut min_line_attempts = 255;

            for line in &board[..] {
                let mut max_cell_attempts = 0;

                for cell in &line[..] {
                    let mut attempts = 0;

                    for num in &numbers[..] {
                        attempts += 1;
                        if num == cell {
                            break;
                        }
                    }
                    max_cell_attempts = cmp::max(attempts, max_cell_attempts);
                }
               min_line_attempts = cmp::min(max_cell_attempts, min_line_attempts);
            }
 
            if min_line_attempts > max_board_attempts {
                winning_board = board.to_vec();
                max_board_attempts = min_line_attempts;
            }
        }
        let winning_number = u64::from(numbers[max_board_attempts-1]);

        let winning_board: HashSet<u64> = HashSet::from_iter(
            winning_board.iter()
                .flatten()
                .map(|num| u64::from(*num))
                .collect::<Vec<u64>>()
                .iter()
                .cloned()
        );

        let said_numbers: Vec<u64> = numbers.iter()
            .take(max_board_attempts)
            .map(|num| u64::from(*num))
            .collect();

        let marked_numbers: Vec<&u64> = winning_board.iter()
            .filter(|number| said_numbers.contains(number))
            .collect();

        let unmarked_numbers: Vec<u64> = winning_board.iter()
            .filter(|number| !marked_numbers.contains(number))
            .map(|num| u64::from(*num))
            .collect();

        let unmarked_sum: u64 = unmarked_numbers.iter().sum();
        println!("{}", winning_number * unmarked_sum);
    }

    Ok(())
}

