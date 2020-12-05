passports = Array.new
STDIN.read.split("\n\n").each do |i|
  passports.push(i.gsub("\n", " "))
end

$required_fields  = [
    ["byr", ->(x) {
      return x.to_i >= 1920 && x.to_i <= 2002
    }],
    ["iyr", ->(x) {
      return x.to_i >= 2010 && x.to_i <= 2020
    }],
    ["eyr", ->(x) {
      return x.to_i >= 2020 && x.to_i <= 2030
    }],
    ["hgt", ->(x) {
      val = x[0...-2].to_i
      if x[-2..] == "cm"
        return val>= 150 && val <= 193
      elsif x[-2..] == "in"
        return val >= 59 && val <= 76
      end
      return false
    }],
    ["hcl", ->(x) {
      return x[0,1] == "#" && x[1..].length == 6
    }],
    ["ecl", ->(x) {
      return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include? x
    }],
    ["pid", ->(x) {
      return x.length == 9
    }]
]

def valid_passport(parts)
  keys = parts.map{|x|x[0,3]}
  $required_fields.each do |f|
    if not keys.include? f[0]
      return false
    end
  end
  return true
end

def validate_passport(parts)
  fields = parts.map{|x|[x[0,3], x[4..].strip()]}
  $required_fields.each do |f|
    field = fields.find{|i| i[0] == f[0]}
    if !f[1].call(field[1])
      return false
    end
  end
  return true
end

s1 = 0
s2 = 0

passports.each do |x|
  parts = x.split(" ")
  if valid_passport(parts)
    s1 += 1
    if validate_passport(parts)
      s2 += 1
    end
  end
end

puts s1
puts s2
