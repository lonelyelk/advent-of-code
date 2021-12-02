# frozen_string_literal: true

# https://adventofcode.com/2021/day/2
module Day02
  def process_input(str)
    str.split("\n").reject(&:empty?).map do |l|
      cmd, num = l.split
      [cmd, num.to_i]
    end
  end

  def problem1(input)
    position, depth = input.inject([0, 0]) { |s, instr| problem1_step(instr, *s) }
    position * depth
  end

  def problem2(input)
    position, depth, = input.inject([0, 0, 0]) { |s, instr| problem2_step(instr, *s) }
    position * depth
  end

  protected

  def problem1_step(instruction, position, depth)
    case instruction
    in ["forward", num]
      [position + num, depth]
    in ["up", num]
      [position, depth - num]
    in ["down", num]
      [position, depth + num]
    end
  end

  def problem2_step(instruction, position, depth, aim)
    case instruction
    in ["forward", num]
      [position + num, depth + (aim * num), aim]
    in ["up", num]
      [position, depth, aim - num]
    in ["down", num]
      [position, depth, aim + num]
    end
  end
end
