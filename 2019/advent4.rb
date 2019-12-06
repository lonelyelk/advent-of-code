num = 0
(307237..769058).each do |pass|
    digits = pass.to_s.chars.map(&:to_i)
    pair_exists = (1..(digits.length-1)).any? do |i|
        digits[i-1] == digits[i] && (digits - [digits[i]]).length == digits.length - 2
    end
    all_asc = (1..(digits.length-1)).all? do |i|
        digits[i-1] <= digits[i]
    end
    if pair_exists && all_asc
        num += 1
        puts pass
    end
end
puts num