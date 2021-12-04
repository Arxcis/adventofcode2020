sum_all = 0
sum_odd = 0
ARGF.each do |line|
  num = line.to_i(base=10)
  sum_all += num
  sum_odd += num % 2 == 1 ? num : 0
end

puts sum_all
puts sum_odd
