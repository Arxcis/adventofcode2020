use std::{io, io::prelude::*};
use std::collections::HashSet;

const PADDING: u64 = 9;

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut heights = Vec::<Vec<u64>>::new();
    let mut i = 0;

    for line in io::stdin().lock().lines() {
        let line = line?;

        let mut heightline = Vec::<u64>::new();
        heightline.push(PADDING);
        for ch in line.chars() {
            heightline.push(u64::from(ch) - 48);
        }
        heightline.push(PADDING);

        if i == 0 {
            let mut pad = Vec::<u64>::new();
            for _ in 0..heightline.len() {
                pad.push(PADDING);
            }
            heights.push(pad);
            i += 1;
        }
        heights.push(heightline);
    }
    let mut pad = Vec::<u64>::new();
    for _ in 0..heights[0].len() {
        pad.push(PADDING);
    }
    heights.push(pad);
    //
    // Part 1
    //
    let mut low_coords = Vec::<(usize,usize)>::new();
    {
        let mut low_points = Vec::<u64>::new();

        for y in 1..heights.len()-1 {
            for x in 1..heights[y].len()-1 {
                let (center, top, left, right, bot) = (
                    heights[y][x],
                    heights[y-1][x],
                    heights[y][x-1],
                    heights[y][x+1],
                    heights[y+1][x]
                );
                if center < top {
                    if center < left {
                        if center < right {
                            if center < bot {
                                low_points.push(center);
                                low_coords.push((x,y));
                            }
                        }
                    }
                }
            }
        }

        let risk_level_sum: u64 = low_points.iter().map(|&it| it + 1).sum();
        println!("{}", risk_level_sum);
    }
    //
    // Part 2
    //
    {
        let mut basin_counts = Vec::<usize>::new();
        for (lowx,lowy) in low_coords {
            let mut visited: HashSet::<(usize,usize)> = HashSet::new();
            let mut next_neighbors: HashSet::<(usize,usize)> = HashSet::<(usize,usize)>::new();
            let mut current_neighbors: HashSet::<(usize,usize)> = HashSet::new();

            current_neighbors.insert((lowx-1,lowy));
            current_neighbors.insert((lowx+1,lowy));
            current_neighbors.insert((lowx,lowy+1));
            current_neighbors.insert((lowx,lowy-1));
            visited.insert((lowx,lowy));

            while current_neighbors.len() > 0 {
                for (x, y) in current_neighbors {
                    if visited.contains(&(x,y)) {
                        continue;
                    }

                    let neighbor = heights[y][x];
                    if neighbor == 9 {
                        continue;
                    }

                    next_neighbors.insert((x+1,y));
                    next_neighbors.insert((x-1,y));
                    next_neighbors.insert((x,y+1));
                    next_neighbors.insert((x,y-1));
                    visited.insert((x,y));
                }
                current_neighbors = next_neighbors.clone();
                next_neighbors.drain();
            }
            basin_counts.push(visited.len());
        }
        basin_counts.sort_by(|a,b| b.cmp(a));
        let three_highest = basin_counts.into_iter().take(3).collect::<Vec<usize>>();
        println!("{:?}", three_highest[0]*three_highest[1]*three_highest[2]);
    }
    Ok(())
}
