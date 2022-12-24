# frozen_string_literal: true

# https://adventofcode.com/2022/day/24
module Year2022
  module Day24
    DIRS = ">v<^"
    DIFFS = (0..3).map { |i| 1i ** i }.freeze
    START = 1 + 0i

    def process_input(str)
      lines = str.split("\n").reject(&:empty?)
      @width = lines.first.size - 2
      @height = lines.size - 2
      @end = @width + (@height + 1) * 1i
      field = Hash.new { |hsh, key| hsh[key] = [] }
      lines.each_with_index do |line, y|
        line.each_char.with_index do |c, x|
          field[x + y * 1i].push(c) if DIRS.include?(c)
        end
      end
      obj = { 1 + 0i => true, @end => true }
      @height.times do |y|
        @width.times do |x|
          pos = x + 1 + (y + 1) * 1i
          obj[pos] = true if field[pos].empty?
        end
      end
      (1...@width.lcm(@height)).each_with_object([obj]) do |_, free|
        field = field.each_with_object(Hash.new { |hsh, key| hsh[key] = [] }) do |(pos, blizz), next_f|
          blizz.each do |c|
            d_pos = 1i ** DIRS.index(c)
            next_pos = pos + d_pos
            next_pos -= @width if next_pos.real > @width
            next_pos -= @height * 1i if next_pos.imag > @height
            next_pos += @width if next_pos.real <= 0
            next_pos += @height * 1i if next_pos.imag <= 0
            next_f[next_pos].push(c)
          end
        end
        obj = { START => true, @width + (@height + 1) * 1i => true }
        @height.times do |y|
          @width.times do |x|
            pos = x + 1 + (y + 1) * 1i
            obj[pos] = true if field[pos].empty?
          end
        end
        free.push(obj)
      end
    end

    def problem1(input, start: START, goal: @end, start_time: 0)
      @min = nil
      paths = [[start]]
      time = start_time
      loop do
        time += 1
        paths = paths.each_with_object([]) do |path, next_paths|
          return time - 1 if path.last == goal

          next if path.size >= input.size && path[path.size - input.size] == path.last

          next_pos = [path.last] + DIFFS.map { |diff| path.last + diff }
          next_pos.each do |pos|
            next unless input[time % input.size][pos]
            next if next_paths.any? { |pth| pth.last == pos }

            next_paths.push([*path, pos])
          end
        end
      end
    end

    def problem2(input)
      time_fw = problem1(input)
      time_back = problem1(input, start: @end, goal: START, start_time: time_fw)
      problem1(input, start_time: time_back)
    end
  end
end
