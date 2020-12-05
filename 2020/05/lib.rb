def number_from(str, high)
  str.chars.inject(0) do |num, char|
    (num << 1) + (char == high ? 1 : 0)
  end
end

def seat_id(str)
  row = number_from(str[0..6], "B")
  seat = number_from(str[7..-1], "R")
  row * 8 + seat
end
