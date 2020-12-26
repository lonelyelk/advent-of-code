def babystep_giantstep(subject, pub, mod)
  m = Math.sqrt(mod).ceil
  map = {}
  e = 1
  (0...m).each do |i|
    map[e] = i
    e = (e * subject) % mod
  end
  factor = subject.pow(mod - m - 1, mod)
  e = pub
  (0...m).each do |i|
    return i * m + map[e] if map[e]
    e = (e * factor) % mod
  end
  nil
end
