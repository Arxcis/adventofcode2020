use std::{io, io::prelude::*};


fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut fish = Vec::<u64>::new();
    for line in io::stdin().lock().lines() {
        let line = line?;
        let numbers = line.split(",").collect::<Vec<&str>>();

        for num_str in numbers {
            let num: u64 = num_str.parse().unwrap();
            fish.push(num);
        }
        break;
    }

    //                                     0,1,2,3,4,5,6,7,8
    let mut fish_groups: Vec::<u64> = vec![0,0,0,0,0,0,0,0,0];
    for f in &fish[..] {
        fish_groups[*f as usize] += 1;
    }
    let simulate = |fish_groups: &mut [u64]| {
        // 0. Save the size of fish group zero in temp var
        let fish_group_zero = fish_groups[0];

        // 1. Move all fish_groups between 1..8 down one group
        for i in 1..fish_groups.len() {
            fish_groups[i-1] = fish_groups[i];
        }

        // 2. Take fish from group zero and add them to group six
        fish_groups[6] += fish_group_zero;

        // 3. Create new fish in group 8 equal to the amount of fish in group zero
        fish_groups[8] = fish_group_zero;
    };
    //
    // Part 1
    //
    {
        for _  in 0..80 {
            simulate(&mut fish_groups);
        }
        // The total fish is the sum of all groups
        let total_fish: &u64 = &fish_groups[..].iter().sum();
        println!("{}", total_fish)
    }
    //
    // Part 2
    //
    {
        for _  in 80..256 {
            simulate(&mut fish_groups);
        }
        // The total fish is the sum of all groups
        let total_fish: &u64 = &fish_groups[..].iter().sum();
        println!("{}", total_fish)
    }
    Ok(())
}
