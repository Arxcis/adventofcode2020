numbers = ARGF.map{ |line| line.to_i(10) }

part1 = nil
part2 = nil

numbers.each do |i|
  numbers.each do |j|
    if part1 == nil and i + j == 2020
      part1 = i*j
    end

    numbers.each do |k|
      if part2 == nil and i + j + k == 2020
        part2 = i*j*k
      end
    end
  end
end

puts part1
puts part2
