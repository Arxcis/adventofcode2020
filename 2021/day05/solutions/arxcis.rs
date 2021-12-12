use std::{io, cmp, io::prelude::*};

// From: "x1,y1 -> x2,y2"
struct Cloud {
    x1: usize,
    y1: usize,
    x2: usize,
    y2: usize
}

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut max_x: usize = 0;
    let mut max_y: usize = 0;
    let mut input = Vec::<Cloud>::new();
    for line in io::stdin().lock().lines() {
        if let Ok(value) = line {

            let split = value.split(" -> ").collect::<Vec<&str>>();
            let split_left = split[0].split(",").collect::<Vec<&str>>();
            let split_right = split[1].split(",").collect::<Vec<&str>>();

            let (x1,y1) = (split_left[0].parse().unwrap(), split_left[1].parse().unwrap());
            let (x2,y2) = (split_right[0].parse().unwrap(), split_right[1].parse().unwrap());

            max_x = cmp::max(max_x, x1);
            max_x = cmp::max(max_x, x2);
            max_y = cmp::max(max_y, y1);
            max_y = cmp::max(max_y, y2);

            let cloud = Cloud{x1,y1,x2,y2};
            input.push(cloud);
        }
    }

    let mut grid = Vec::<Vec<usize>>::new();
    for _ in 0..max_y+1 {
        let mut row = Vec::<usize>::new();
        for _ in 0..max_x+1 {
            row.push(0);
        }
        grid.push(row);
    }
    //
    // Part 1
    //
    {
        for Cloud{x1,y1,x2,y2} in &input[..] {
            if x1 != x2 && y1 != y2 {
                // Only use vertical or horizontal lines - this line is neither.
                continue;
            }
            if y1 == y2 {
                // If horizontal line
                let y = *y1;
                for x in cmp::min(*x1,*x2)..cmp::max(*x1,*x2)+1 {
                    grid[y][x] += 1;
                }
            }
            if x1 == x2 {
                // If vertical line
                let x = *x1;
                for y in cmp::min(*y1,*y2)..cmp::max(*y1,*y2)+1 {
                    grid[y][x] += 1;
                }
            }
        }

        let mut more_than_one_hit_count = 0;
        for rows in &grid[..] {
            for cell in &rows[..] {
                if *cell > 1 {
                    more_than_one_hit_count += 1;
                }
            }
        }
        println!("{}", more_than_one_hit_count);
    }
    //
    // Part 2
    //
    {
        for Cloud{x1,y1,x2,y2} in &input[..] {
            if x1 == x2 || y1 == y2 {
                // Only consider diagonal lines - this line is vertical or horizontal.
                continue;
            }

            // If diagonal line
            if x1 < x2 {
                if y1 < y2 {
                    for i in 0..(x2-x1)+1 {
                        let x = x1 + i;
                        let y = y1 + i;
                        grid[y][x] += 1;
                    }
                }
                if y1 > y2 {
                    for i in 0..(x2-x1)+1 {
                        let x = x1 + i;
                        let y = y1 - i;
                        grid[y][x] += 1;
                    }
                }
            }
            if x1 > x2 {
                if y1 < y2 {
                    for i in 0..(x1-x2)+1 {
                        let x = x1 - i;
                        let y = y1 + i;
                        grid[y][x] += 1;
                    }
                }
                if y1 > y2 {
                    for i in 0..(x1-x2)+1 {
                        let x = x1 - i;
                        let y = y1 - i;
                        grid[y][x] += 1;
                    }
                }
            }
        }

        let mut more_than_one_hit_count = 0;
        for rows in &grid[..] {
            for cell in &rows[..] {
                if *cell > 1 {
                    more_than_one_hit_count += 1;
                }
            }
        }
        println!("{}", more_than_one_hit_count);
    }
    Ok(())
}
