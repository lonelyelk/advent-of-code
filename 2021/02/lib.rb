# frozen_string_literal: true

module Day02
  def process_input(str)
    str.split("\n").reject(&:empty?).map do |l|
      cmd, num = l.split
      [cmd, num.to_i]
    end
  end

  def problem1(input)
    position, depth = input.inject([0, 0]) do |s, instr|
      pos, depth = s
      case instr
      in ["forward", num]
        [pos + num, depth]
      in ["up", num]
        [pos, depth - num]
      in ["down", num]
        [pos, depth + num]
      end
    end
    position * depth
  end

  def problem2(input)
    position, depth, = input.inject([0, 0, 0]) do |s, instr|
      pos, depth, aim = s
      case instr
      in ["forward", num]
        [pos + num, depth + (aim * num), aim]
      in ["up", num]
        [pos, depth, aim - num]
      in ["down", num]
        [pos, depth, aim + num]
      end
    end
    position * depth
  end
end
