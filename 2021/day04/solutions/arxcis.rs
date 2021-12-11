use std::{io, cmp, io::prelude::*};

fn main() -> io::Result<()> {
    let mut input = Vec::<String>::new();
    for line in io::stdin().lock().lines() {
        input.push(line?);
    }
  
    let numbers: Vec<u8> = input[0].split(",").map(|val| val.parse().unwrap()).collect();
    
    let mut min_board = Vec::<Vec::<u8>>::new();
    let mut min_board_attempts = 255;

    for i in (2..input.len()).step_by(6) {
        
        println!("{}", input[i]);
        
        for line in input[i+0].trim().split(" ") {
            println!("{}", line);
        }

        let brow: Vec<u8> = input[i+0].trim().split(" ").map(|val|val.parse().unwrap()).collect();


        let irow: Vec<u8> = input[i+1].trim().split(" ").map(|val|val.parse().unwrap()).collect();
        let nrow: Vec<u8> = input[i+2].trim().split(" ").map(|val|val.parse().unwrap()).collect();
        let grow: Vec<u8> = input[i+3].trim().split(" ").map(|val|val.parse().unwrap()).collect();
        let orow: Vec<u8> = input[i+4].trim().split(" ").map(|val|val.parse().unwrap()).collect();

        let bcol: Vec<u8> = vec![brow[0],irow[1],nrow[2],grow[3],orow[4]];
        let icol: Vec<u8> = vec![brow[0],irow[1],nrow[2],grow[3],orow[4]];
        let ncol: Vec<u8> = vec![brow[0],irow[1],nrow[2],grow[3],orow[4]];
        let gcol: Vec<u8> = vec![brow[0],irow[1],nrow[2],grow[3],orow[4]];
        let ocol: Vec<u8> = vec![brow[0],irow[1],nrow[2],grow[3],orow[4]];

        let board = vec![brow,irow,nrow,grow,orow,bcol,icol,ncol,gcol,ocol];
    
        let mut min_line_attempts = 255;

        for line in &board[..] {
            let mut max_cell_attempts = 0;

            for cell in &line[..] {
                let mut attempts = 0;

                for num in &numbers[..] {
                    if num != cell {
                        attempts += 1;
                        continue; 
                    } else {
                        break;   
                    }
                }
                max_cell_attempts = cmp::max(attempts, max_cell_attempts);
            }
            min_line_attempts = cmp::min(
                max_cell_attempts,
                min_line_attempts, 
            );
        }
        
        if min_line_attempts < min_board_attempts {
            println!("{}", min_line_attempts);
            min_board_attempts = min_line_attempts;
            min_board = board;
        }
    }
    
    println!("{:?}", min_board);
    Ok(())
}

