def number_to_digits(num)
  num.to_s.chars.map(&:to_i)
end

def has_same?(digits)
  (1...digits.length).any? { |i| digits[i-1] == digits[i] }
end

def is_not_desc?(digits)
  (1...digits.length).all? { |i| digits[i-1] <= digits[i] }
end

def pass_p1?(digits)
  has_same?(digits) && is_not_desc?(digits)
end

def count_passing_p1(range)
  range.count { |num| pass_p1?(number_to_digits(num)) }
end

def has_pair?(digits)
  (1...digits.length).any? do |i|
    digits[i-1] == digits[i] && (digits - [digits[i]]).length == digits.length - 2
  end
end

def pass_p2?(digits)
  has_pair?(digits) && is_not_desc?(digits)
end

def count_passing_p2(range)
  range.count { |num| pass_p2?(number_to_digits(num)) }
end
