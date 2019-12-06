def fuel(m)
  m / 3 - 2
end

def full_fuel(m)
  re = 0
  while m >= 9
    m = fuel(m)
    re += m
  end
  re
end
