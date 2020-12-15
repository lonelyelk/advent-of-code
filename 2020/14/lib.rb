class Mask
  attr_reader :and_mask, :or_mask, :float_bits

  def initialize(str)
    @and_mask = str.chars.inject(0) do |acc, char|
      (acc << 1) + (char == "0" ? 0 : 1)
    end
    @or_mask = str.chars.inject(0) do |acc, char|
      (acc << 1) + (char == "1" ? 1 : 0)
    end
    @float_bits = str.chars.reverse.each_with_object([]).with_index do |(char, bit_arr), index|
      bit_arr.push(index) if char == "X"
    end
  end

  def apply(num)
    (num & and_mask) | or_mask
  end

  def apply_floating(num)
    new_num = num | or_mask
    float_bits.inject([new_num]) do |acc, bit_num|
      apply_floating_bit(acc, 1 << bit_num)
    end
  end

  def apply_floating_bit(arr, bit)
    arr.each_with_object([]) do |num, res|
      if num & bit == 0
        res.push(num | bit)
      else
        res.push(num - bit)
      end
      res.push(num)
    end
  end
end

def init(instructions)
  mask = nil
  instructions.each_with_object({}) do |instruction, mem|
    if (md = instruction.match(/^mask = (\S+)$/))
      mask = Mask.new(md[1])
    elsif (md = instruction.match(/^mem\[(\d+)\] = (\d+)$/))
      mem[md[1]] = mask.apply(md[2].to_i)
    else
      raise "bad instruction"
    end
  end.values.inject(&:+)
end

def init_v2(instructions)
  mask = nil
  instructions.each_with_object({}) do |instruction, mem|
    if (md = instruction.match(/^mask = (\S+)$/))
      mask = Mask.new(md[1])
    elsif (md = instruction.match(/^mem\[(\d+)\] = (\d+)$/))
      mask.apply_floating(md[1].to_i).each do |address|
        mem[address] = md[2].to_i
      end
    else
      raise "bad instruction"
    end
  end.values.inject(&:+)
end
