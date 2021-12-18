use std::{io, io::prelude::*};

const OFFSET: u8 = 65;

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut rules: Vec<u8> = vec![0; 1 << 13]; // 2^13 u8 = 8kB
    let mut counts: Vec<u64> = vec![0; 1 << 5]; // 2^5 u64 = 128B
    let mut template: Vec<u8> = Vec::new();

    let mut i: u64 = 0;
    for line in io::stdin().lock().lines() {
        let line = line?;

        match i {
            0 => {
                for c in line.chars() {
                    template.push(c as u8 - OFFSET);
                }
            },
            1 => (),
            _ => {
                let split = line.split(" -> ").collect::<Vec<&str>>();
                let (key, value) = (split[0], split[1]);

                let bytes = key.chars().map(|c| (c as u8) - OFFSET).collect::<Vec<u8>>();

                let (high_byte, low_byte) = (bytes[0], bytes[1]);
                let key_byte = (high_byte as usize) << 8 | low_byte as usize;

                let rule_byte = (value.chars().next().unwrap() as u8) - OFFSET;
                rules[key_byte] = rule_byte;
            },
        }
        i += 1;
    }
    //
    // Part 1 - Apply 10 steps of pair insertion to the polymer template and find the most and least common elements in the result.
    //
    {
        let mut pairs: Vec<u64> = vec![0; 1 << 13]; // 8kB * 8 = 64kB
        // Init pairs
        for i in 0..template.len() {
            let left = template[i] as usize;
            counts[left] += 1;
            if i == template.len() - 1 {
                break; 
            }
            let right = template[i+1] as usize;
            let pair = left << 8 | right;

            pairs[pair] += 1;
        }

        // Count polymer letters
        for i in 0..40 {
            let mut next_pairs: Vec<u64> = vec![0; 1 << 13]; // 8kB * 8 = 64kB
            for pair in 0..pairs.len() {
                if pairs[pair] == 0 {
                    continue;
                }
                
                let insertion = rules[pair] as usize;
                let left = (pair & 0b1111_1111_0000_0000) >> 8;
                let right = pair & 0b0000_0000_1111_1111;
        
                counts[insertion] += 1 * pairs[pair];

                next_pairs[left << 8 | insertion] += 1 * pairs[pair];
                next_pairs[insertion << 8 | right] += 1 * pairs[pair];
           }
           pairs = next_pairs;
           //
           // Part 1: N == 10
           //
           if i == 9 {
               // Count
               let counts = counts.iter().filter(|&it| *it != 0).map(|&it| u64::from(it)).collect::<Vec<u64>>();
               let max = counts.iter().max().unwrap();
               let min = counts.iter().min().unwrap();
               println!("{:?}", max-min);
           }
        }
        //
        // Part 2: N == 40
        //
        let counts = counts.iter().filter(|&it| *it != 0).map(|&it| u64::from(it)).collect::<Vec<u64>>();
        let max = counts.iter().max().unwrap();
        let min = counts.iter().min().unwrap();
        println!("{:?}", max-min);       
    }
    Ok(())
}
