def memory_game(starting_numbers, end_turn)
  mem = starting_numbers.each_with_object({}).with_index do |(num, m), index|
    m[num] = [index + 1]
  end
  prev = starting_numbers.last
  ((starting_numbers.length+1)..end_turn).each do |turn|
    num = if mem[prev].length > 1
      mem[prev][-1] - mem[prev][-2]
    else
      0
    end
    mem[num] ||= []
    mem[num].push(turn)
    prev = num
  end
  prev
end
