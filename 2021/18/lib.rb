# frozen_string_literal: true

# https://adventofcode.com/2021/day/18
# rubocop:disable Metrics/ModuleLength, Metrics/MethodLength, Metrics/AbcSize
module Day18
  def process_input(str)
    str.split("\n").reject(&:empty?).map do |l|
      process_line(l)
    end
  end

  def process_line(line)
    current_path = []
    line.chars.each_with_object([]) do |c, res|
      case c
      when "["
        current_path += [:l]
      when ","
        current_path += [:r]
      when "]"
        current_path = current_path[0..-2]
      when /\d/
        res.push({ path: current_path, value: c.to_i })
        current_path = current_path[0..-2]
      end
    end
  end

  def explode(num)
    res = num.map(&:dup)
    to_expl = res.index { |n| n[:path].size > 4 }
    until to_expl.nil?
      left = [{ path: res[to_expl][:path][0..-2], value: 0 }]
      if to_expl.positive?
        res[to_expl - 1][:value] += res[to_expl][:value]
        left = res[0..(to_expl - 1)] + left
      end
      if to_expl < res.size - 2
        res[to_expl + 2][:value] += res[to_expl + 1][:value]
        left += res[(to_expl + 2)..]
      end
      res = left
      to_expl = res.index { |n| n[:path].size > 4 }
    end
    res
  end

  def add(num1, num2)
    num1.map { |n| { path: [:l] + n[:path], value: n[:value] } } +
      num2.map { |n| { path: [:r] + n[:path], value: n[:value] } }
  end

  def split(num)
    to_split = num.index { |n| n[:value] > 9 }
    return num if to_split.nil?

    val = num[to_split][:value] / 2
    left = [
      { path: num[to_split][:path] + [:l], value: val },
      { path: num[to_split][:path] + [:r], value: num[to_split][:value] - val },
    ]
    left = num[0..(to_split - 1)] + left if to_split.positive?
    left += num[(to_split + 1)..] if to_split < num.size - 1
    left
  end

  def add_list(input)
    cnt = 0
    input.inject do |acc, num|
      cnt += 1
      sum = add(acc, num)
      loop do
        expl = explode(sum)
        spl = split(expl)
        break if spl == sum

        sum = spl
      end
      sum
    end
  end

  def number_to_s(num)
    case num.size
    when 1
      num[0][:value].to_s
    when 2
      "[#{num.map { |n| n[:value] }.join(",")}]"
    else
      parts = direction_chunks(num).map do |_dir, part|
        number_to_s(trim_outer_direction(part))
      end
      "[#{parts.join(",")}]"
    end
  end

  def magnitude(num)
    case num.size
    when 1
      num[0][:value]
    when 2
      (num[0][:value] * 3) + (num[1][:value] * 2)
    else
      parts = direction_chunks(num).map do |_dir, part|
        magnitude(trim_outer_direction(part))
      end
      (parts[0] * 3) + (parts[1] * 2)
    end
  end

  def problem1(input)
    magnitude(add_list(input))
  end

  def problem2(input)
    input.combination(2).map do |pair|
      [magnitude(add_list(pair)), magnitude(add_list(pair.reverse))]
    end.flatten.max
  end

  protected

  def direction_chunks(number)
    number.chunk { |num| num[:path].first }
  end

  def trim_outer_direction(number)
    number.map { |num| { path: num[:path][1..], value: num[:value] } }
  end
end
# rubocop:enable Metrics/ModuleLength, Metrics/MethodLength, Metrics/AbcSize
