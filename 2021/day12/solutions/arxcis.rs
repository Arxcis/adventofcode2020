use std::{io, io::prelude::*};
use std::collections::HashMap;
use std::collections::HashSet;

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut caves = HashMap::<String, HashSet::<String>>::new();

    for line in io::stdin().lock().lines() {
        let line = line?;

        let split: Vec<String> = line.split("-").map(|s| s.to_string()).collect();
        let (key, other_key) = (&split[0], &split[1]);

        {
            let cave: &mut HashSet::<String> = caves.entry(key.to_string())
                .or_insert(HashSet::new());

            cave.insert(other_key.to_string());
        }
        {
            let cave: &mut HashSet::<String> = caves.entry(other_key.to_string())
                .or_insert(HashSet::new());

            cave.insert(key.to_string());
        }
    }
    //
    // Part 1
    //
    {
        let paths = visit_cave(&caves, "".to_string(), "start", "");
        println!("{}", paths.len());
    }
    //
    // Part 2
    //
    {
        let small_caves = caves.iter()
            .filter(|(cave,_)| match cave.chars().next().unwrap() {
                'a'..='z' => if *cave == "start" || *cave == "end" { None } else { Some(cave) },
                _ => None,
            } != None)
            .map(|(cave,_)| cave.to_string()).collect::<Vec<String>>();

        let mut paths = HashSet::<String>::new();
        for twice_cave in small_caves.iter() {
            let res = visit_cave(&caves, "".to_string(), "start", twice_cave);
            paths.extend(res);
        }

        println!("{:?}", paths.len());
    }
    Ok(())
}


fn visit_cave(
    caves: &HashMap::<String, HashSet::<String>>,
    mut path: String,
    start_key: &str,
    twice_key: &str
) -> HashSet::<String> {

    let cave = caves.get(start_key).unwrap();

    // Make sure one small cave can be visited twice
    // Make sure we visit small caves at most once
    let first_letter = start_key.chars().next().unwrap();
    match first_letter {
        'a'..='z' => {
            let occurances = path.matches(start_key).count();
            if start_key != twice_key && occurances == 1
            || start_key == twice_key && occurances == 2 {
                return HashSet::new();
            }
        },
        _ => ()
    }

    path.push_str("/");
    path.push_str(start_key);

    // Your goal is to find the number of distinct paths that start at start, end at end..
    if start_key == "end" {
        let mut paths = HashSet::<String>::new();
        paths.insert(path.to_string());
        return paths;
    }

    let mut paths: HashSet::<String> = HashSet::<String>::new();
    for peer_key in cave.iter() {
        let res = visit_cave(caves, path.to_string(), peer_key, twice_key);
        paths.extend(res);
    }

    return paths;
}
