def cut(arr, n)
  arr.rotate(n)
end

def index_before_cut(length, index, n)
  (index + n) % length
end

def new_stack(arr)
  arr.reverse
end

def index_before_new_stack(length, index)
  -(index + 1) % length
end

def deal_with_inc(arr, n)
  new_arr = Array.new(arr.length)
  arr.each do |i|
    new_arr[(i * n) % arr.length] = arr[i]
  end
  new_arr
end

def index_before_deal_with_inc(length, index, n)
  cycle = (0..n).to_a.detect { |c| (c*length + index) % n == 0 }
  (cycle * length + index) / n
end

def shuffle(arr, instructions)
  instructions.inject(arr) do |sh_arr, instr|
    if (md = instr.match(/cut (-?[0-9]+)/))
      cut(sh_arr, md[1].to_i)
    elsif instr.match(/deal into new stack/)
      new_stack(sh_arr)
    elsif (md = instr.match(/deal with increment ([0-9]+)/))
      deal_with_inc(sh_arr, md[1].to_i)
    end
  end
end

def index_before_shuffle(length, index, instructions)
  instructions.reverse.inject(index) do |sh_index, instr|
    if (md = instr.match(/cut (-?[0-9]+)/))
      index_before_cut(length, sh_index, md[1].to_i)
    elsif instr.match(/deal into new stack/)
      index_before_new_stack(length, sh_index)
    elsif (md = instr.match(/deal with increment ([0-9]+)/))
      index_before_deal_with_inc(length, sh_index, md[1].to_i)
    end
  end
end

def c_d_instructions(instructions, length)
  d = 0
  c = 1
  instructions.each do |instr|
    if (md = instr.match(/cut (-?[0-9]+)/))
      d -= md[1].to_i
    elsif instr.match(/deal into new stack/)
      d = -d - 1
    elsif (md = instr.match(/deal with increment ([0-9]+)/))
      d *= md[1].to_i
      c *= md[1].to_i
    end
  end
  [c % length, d % length]
end

def rev_c_d_instructions(instructions, length)
  d = 0
  c = 1
  instructions.reverse.each do |instr|
    if (md = instr.match(/cut (-?[0-9]+)/))
      d += md[1].to_i
    elsif instr.match(/deal into new stack/)
      d += 1
      d = -d
      c = -c
    elsif (md = instr.match(/deal with increment ([0-9]+)/))
      inc = md[1].to_i.pow(length-2, length)
      d *= inc
      c *= inc
    end
  end
  [c % length, d % length]
end

def rev_index(instructions, length, times, index)
  c, d = rev_c_d_instructions(instructions, length)
  c1 = c.pow(times, length)
  (index * c1 + d * (c1 + length - 1) * (c - 1).pow(length - 2, length)) % length
end
