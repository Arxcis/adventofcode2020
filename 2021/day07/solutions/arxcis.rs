use std::{io, cmp, io::prelude::*};


fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut crabs = Vec::<u64>::new();
    for line in io::stdin().lock().lines() {
        let line = line?;
        let nums = line.split(",").collect::<Vec<&str>>();

        for num in nums {
            let num: u64 = num.parse().unwrap();
            crabs.push(num);
        }
    }
    let min_crab: u64 = *(crabs.iter().min().unwrap());
    let max_crab: u64 = *(crabs.iter().max().unwrap());
    //
    // Part 1
    //
    {
        let mut min_fuel_cost = u64::pow(2, 63);
        for i in min_crab..max_crab {

            let mut total_fuel_cost: u64 = 0;
            for crab in &crabs[..] {
                let this_fuel_cost = cmp::max(i,*crab) - cmp::min(i,*crab);
                total_fuel_cost += this_fuel_cost;
            }
            min_fuel_cost = cmp::min(min_fuel_cost, total_fuel_cost);
        }
        println!("{}", min_fuel_cost);
    }
    //
    // Part 2
    //
    {
        let mut min_fuel_cost = u64::pow(2, 63);
        for i in min_crab..max_crab {

            let mut total_fuel_cost: u64 = 0;
            for crab in &crabs[..] {
                let n = cmp::max(i,*crab) - cmp::min(i,*crab);
                //
                // The sum of the integers from 1 to n is "(n*(n+1)) // 2".
                // @ref https://math.stackexchange.com/a/1100915
                //
                let crab_fuel_cost = n*(n+1)/2;
                total_fuel_cost += crab_fuel_cost;
            }
            min_fuel_cost = cmp::min(min_fuel_cost, total_fuel_cost);
        }
        println!("{}", min_fuel_cost);
    }
    Ok(())
}
