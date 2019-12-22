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
  length - 1 - index
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

def shuffle2(index, instructions)
  instructions.inject(index) do |i, instr|
    if (md = instr.match(/cut (-?[0-9]+)/))
      i - md[1].to_i
    elsif instr.match(/deal into new stack/)
      -i
    elsif (md = instr.match(/deal with increment ([0-9]+)/))
      i * md[1].to_i
    end
  end
end
