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

def fft_apply(input, phases, offset = 0)
  re = input
  phases.times do |i|
    re = fft_phase(re, offset)
  end
  re[offset, 8].join
end
