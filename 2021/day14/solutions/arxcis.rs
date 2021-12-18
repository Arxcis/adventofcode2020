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
    // {
    //     let mut polymer = template.clone();

    //     let now = std::time::Instant::now();
    //     for _ in 0..25 {
    //         polymer = extend_polymer_naive(&polymer, &rules);
    //     }
    //     println!("total elapsed: {}ms", now.elapsed().as_millis());

    //     for byte in polymer {
    //         counts[byte as usize] += 1;
    //     }
    //     counts.sort_by(|a,b| b.cmp(a));
    //     let counts = counts.iter().filter(|&a| *a != 0).map(|a| u64::from(*a)).collect::<Vec<u64>>();
    //     let max = counts[0];
    //     let min = counts[counts.len() - 1];
    //     println!("{:?}", max-min);
    // }
    // @optimization
  //  {
     //   for i in 0..template.len()-1 {
       //     let current = template[i] as usize;
         //   let next = template[i+1] as usize;
        //    counts[current] += 1;
        //    extend_polymer_recursive(&rules, current, next, 0, 25, &mut counts);
     //   }
 //       counts[template[template.len()-1] as usize] += 1;
//
   //     counts.sort_by(|a,b| b.cmp(a));
       // let counts = counts.into_iter().filter(|&a| a != 0).collect::<Vec<u64>>();
     //   let max = counts[0];
      //  let min = counts[counts.len() - 1];
     //   println!("{:?}", max-min);
   // }
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


fn _extend_polymer_recursive(rules: &Vec<u8>, current: usize, next: usize, i: usize, n: usize, counts: &mut Vec<u64>)  {
    let pair: usize = current << 8 | next;
    let insert = rules[pair] as usize;

    counts[insert] += 1;

    if i + 1 < n {
        _extend_polymer_recursive(rules, current, insert, i + 1, n, counts);
        _extend_polymer_recursive(rules, insert, next, i + 1, n, counts);
    }
}


fn _extend_polymer_naive(polymer: &Vec<u8>, rules: &Vec<u8>) -> Vec<u8> {

    let mut next_polymer: Vec<u8> = Vec::with_capacity(polymer.len() * 2);

    for i in 0..polymer.len()-1 {
        // 27%
        let current = polymer[i];
        // 25%
        let next = polymer[i+1];
        // 15%
        let key: usize = (current as usize) << 8 | next as usize;
        // 25%
        let rule = rules[key];
        // 18%
        next_polymer.push(current);
        // 18%
        next_polymer.push(rule);

    }

    let last_char = polymer[polymer.len()-1];
    next_polymer.push(last_char);

    next_polymer
}
