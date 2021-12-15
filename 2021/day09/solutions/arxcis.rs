use std::{io, io::prelude::*};

const PADDING: u64 = 100;

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

    }
    Ok(())
}
