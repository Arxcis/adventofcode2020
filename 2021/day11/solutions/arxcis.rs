use std::{io, io::prelude::*};
use std::collections::HashSet;

const PADDING: u64 = 999;

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut jellyfish = Vec::<Vec<u64>>::new();
    let mut i = 0;

    for line in io::stdin().lock().lines() {
        let line = line?;
        
        let mut jellyfishline = Vec::<u64>::new();
        jellyfishline.push(PADDING);
        for ch in line.chars() {
            jellyfishline.push(u64::from(ch)-48); 
        }
        jellyfishline.push(PADDING);

        if i == 0 {
            let mut pad = Vec::<u64>::new();
            for _ in jellyfishline.iter() {
                pad.push(PADDING);
            }
            jellyfish.push(pad);
            i += 1;
        }
        jellyfish.push(jellyfishline);
    }
    let mut pad = Vec::<u64>::new();
    for _ in jellyfish[0].iter() {
        pad.push(PADDING);
    }
    jellyfish.push(pad);
    //
    // Simulate step
    //
    let simulate = |jellyfish: &mut Vec::<Vec<u64>>| -> u64 {
        // First, the energy level of each octopus increases by 1.
        for y in 1..jellyfish.len() - 1 {
            for x in 1..jellyfish[y].len() - 1 {
                jellyfish[y][x] += 1;
            }
        }
       
        // Then, any octopus with an energy level greater than 9 flashes. This increases the energy level of all adjacent octopuses by 1, including octopuses that are diagonally adjacent. If this causes an octopus to have an energy level greater than 9, it also flashes. This process continues as long as new octopuses keep having their energy level increased beyond 9. (An octopus can only flash at most once per step.)
        let mut flashed = HashSet::<(usize,usize)>::new();
        let mut total_flashes: u64 = 0;

        loop {
            let mut flash_count = 0;

            for y in 1..jellyfish.len() - 1 {
                for x in 1..jellyfish[y].len() - 1 {

                    if flashed.contains(&(x,y)) {
                        continue;
                    }

                    if jellyfish[y][x] > 9 {
                        flash_count += 1;
                        flashed.insert((x,y));

                        jellyfish[y][x-1] += 1;
                        jellyfish[y][x+1] += 1;
                        jellyfish[y-1][x-1] += 1;
                        jellyfish[y-1][x] += 1;
                        jellyfish[y-1][x+1] += 1;
                        jellyfish[y+1][x-1] += 1;
                        jellyfish[y+1][x] += 1;
                        jellyfish[y+1][x+1] += 1;
                    }
                }
            }
            total_flashes += flash_count;
            if flash_count == 0 {
                break;
            }
        }
        // Finally, any octopus that flashed during this step has its energy level set to 0, as it used all of its energy to flash.
        for y in 1..jellyfish.len() - 1 {
            for x in 1..jellyfish[y].len() - 1 {
                if jellyfish[y][x] > 9 {
                    jellyfish[y][x] = 0;
                }
            }
        }
        total_flashes
    };
    //
    // Part 1
    //
    let mut n = 0;
    {    
        let mut total_flashes: u64 = 0;
        for _ in 0..100 {
            total_flashes += simulate(&mut jellyfish);
            n += 1;
        }

        println!("{:?}", total_flashes);
    }
    //
    // Part 2
    //
    { 
        loop {
            simulate(&mut jellyfish);
            n += 1;
            
            let mut every_jellyfish_in_sync = true;
            for y in 1..jellyfish.len() - 1 {
                for x in 1..jellyfish[y].len() - 1 {
                    if jellyfish[y][x] != 0 {
                         every_jellyfish_in_sync = false;
                    }
                }
            }
            if every_jellyfish_in_sync == true {
                break;
            }
        }
        println!("{}", n);
    }
    Ok(())
}

