use std::{io, cmp, io::prelude::*};
use std::collections::HashSet;

#[derive(Debug)]
enum Axis {
    X,
    Y,
}

#[derive(Debug)]
struct Dot {
    x: usize,
    y: usize,
}

#[derive(Debug)]
struct Fold {
    axis: Axis,
    value: usize, 
} 

fn main() -> io::Result<()> {
    //
    // Parse
    //
    let mut dots = Vec::<Dot>::new();
    let mut folds = Vec::<Fold>::new();

    for line in io::stdin().lock().lines() {
        let line = line?;
               match line.chars().next() {
            Some(ch) => {
                match ch {
                    '0'..='9' => {
                        let split = line.split(",").collect::<Vec<&str>>();
                        let (x,y) = (split[0],split[1]);
                        let dot = Dot{x: x.parse().unwrap(), y: y.parse().unwrap()};
                        dots.push(dot);
                    }, 
                    'f' => {
                        let split = line.split(" along ").collect::<Vec<&str>>();
                        let fold = split[1];
                        let split = fold.split("=").collect::<Vec<&str>>();
                        let (axis,value) = (split[0], split[1]);
                        let fold = Fold{
                            axis: match axis.chars().next().unwrap() { 
                                'y' => Axis::Y,
                                'x' => Axis::X,
                                _ => panic!("HELP unknown axis {}", axis)
                            },
                            value: value.parse().unwrap(),
                        };
                        folds.push(fold);
                    },
                    _ => ()
                }
            },
            None => ()
        }
    }
    //
    // Part 1
    // The transparent paper is pretty big, so for now, focus on just completing the first fold.
    {
        let first_fold = &folds[0];
        
        for dot in &mut dots[..] {
            match &first_fold.axis {
                Axis::X if dot.x > first_fold.value => {
                    dot.x = first_fold.value - (dot.x - first_fold.value);
                },
                Axis::Y if dot.y > first_fold.value => {
                    dot.y = first_fold.value - (dot.y - first_fold.value);
                },
                _ => (),
            };
        }
        let mut dotset = HashSet::<(usize,usize)>::new();
        for dot in &dots[..] {
            dotset.insert((dot.x, dot.y));
        }
        println!("{:?}", dotset.len());
    }
    //
    // Part 2
    //
    {
        for fold in &folds[1..] {
            for dot in &mut dots[..] {
                match &fold.axis {
                    Axis::X if dot.x > fold.value => {
                        dot.x = fold.value - (dot.x - fold.value);
                    },
                    Axis::Y if dot.y > fold.value => {
                        dot.y = fold.value - (dot.y - fold.value);
                    },
                    _ => (),
                };
            }
        }
        
        let mut max_y = 0;
        let mut max_x = 0;
        let mut dotset = HashSet::<(usize, usize)>::new();
        for dot in &dots[..] {
            dotset.insert((dot.x, dot.y));
            max_y = cmp::max(max_y, dot.y);
            max_x = cmp::max(max_x, dot.x);
        }
        let mut paper = Vec::<Vec::<bool>>::new();
        for _ in 0..max_y+1 {
            let mut line = Vec::<bool>::new();
            for _ in 0..max_x+1 {
                line.push(false);
            }
            paper.push(line);
        }
        for Dot{x,y} in &dots[..] {
            paper[*y][*x] = true;
        }
        for line in paper {
            for dot in line {
                match dot {
                    true => print!("#"),
                    false => print!("."),
                }
            }
            println!("");
        }
    }
    Ok(())
}
