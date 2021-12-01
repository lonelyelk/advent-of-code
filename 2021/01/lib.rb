def process_input(str)
  str.split("\n").reject(&:empty?).map(&:to_i)
end
