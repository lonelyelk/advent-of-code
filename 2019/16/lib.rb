def fft_phase(input, offset = 0)
  arr = input[offset..-1].map.with_index do |_, index|
    sum = 0
    input[(index+offset)..-1].each_slice(index+1).with_index do |slice, i|
      m = i % 4
      next if m == 1 || m == 3
      if m == 0
        sum += slice.inject(&:+)
      else
        sum -= slice.inject(&:+)
      end
    end

    sum.abs.digits.first
  end
  input[0...offset] + arr
end

def fft_phase_v2(input, offset)
  out = Array.new(input.length)
  help = Array.new(input.length)
  count = input.length - 1
  out[input.length - 1] = help[input.length - 1] = input.last
  while count >= offset
    count -= 1
    help[count] = help[count + 1] + input[count]
    out[count] = help[count].digits.first
  end
  out
end

def fft_apply(input, phases, offset = 0)
  re = input
  phases.times do |i|
    re = fft_phase(re, offset)
  end
  re[offset, 8].join
end

def fft_apply_v2(input, phases, offset)
  raise "ERROR" if offset < input.length / 2
  re = input
  phases.times do |i|
    re = fft_phase_v2(re, offset)
  end
  re[offset, 8].join
end
