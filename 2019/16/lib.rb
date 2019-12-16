def fft_phase(input, base_pattern)
  base = base_pattern.map { |e| [e] }
  input.map.with_index do |_, index|
    base_index = 0
    base_step = base.map { |arr| arr * (index + 1) }.flatten
    input.inject(0) do |acc, digit|
      base_index += 1
      base_index = 0 if base_index >= base_step.length
      acc + digit * base_step[base_index]
    end.abs.digits.first
  end
end

def fft_apply(input, base_pattern, phases)
  re = input
  phases.times do
    re = fft_phase(re, base_pattern)
  end
  re
end
