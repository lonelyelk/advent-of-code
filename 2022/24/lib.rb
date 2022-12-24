# frozen_string_literal: true

# https://adventofcode.com/2022/day/24
module Year2022
  module Day24
    DIRS = ">v<^"
    DIFFS = (0..3).map { |i| 1i**i }.freeze
    START = 1 + 0i

    def process_input(str)
      field = init_field(str)
      @period = @width.lcm(@height)
      (0...@period).each_with_object([]) do |i, free|
        field = advance_blizzard(field) unless i.zero?
        free.push(free_space_on_field(field))
      end
    end

    # rubocop:disable Metrics/MethodLength
    def problem1(input, start: START, goal: @end, start_time: 0)
      paths = [[start]]
      time = start_time
      loop do
        time += 1
        paths, = paths.each_with_object([[], []]) do |path, (next_paths, other_moves)|
          good_moves(path, other_moves, input[time % @period]).each do |pos|
            return time if pos == goal

            next_paths.push([*path, pos])
            other_moves.push(pos)
          end
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def problem2(input)
      time_fw = problem1(input)
      time_back = problem1(input, start: @end, goal: START, start_time: time_fw)
      problem1(input, start_time: time_back)
    end

    private

    def init_field(raw_input)
      lines = raw_input.split("\n").reject(&:empty?)
      init_vars(lines)
      lines.each_with_object(hash_arr).with_index do |(line, field), y|
        line.each_char.with_index do |c, x|
          field[x + y * 1i].push(c) if DIRS.include?(c)
        end
      end
    end

    def init_vars(lines)
      @width = lines.first.size - 2
      @height = lines.size - 2
      @end = @width + (@height + 1) * 1i
    end

    def hash_arr
      Hash.new { |hsh, key| hsh[key] = [] }
    end

    def advance_blizzard(field)
      field.each_with_object(hash_arr) do |(pos, blizz), next_f|
        blizz.each do |c|
          d_pos = 1i**DIRS.index(c)
          next_pos = trim(pos + d_pos)
          next_f[next_pos].push(c)
        end
      end
    end

    def trim(pos)
      pos -= @width if pos.real > @width
      pos -= @height * 1i if pos.imag > @height
      pos += @width if pos.real <= 0
      pos += @height * 1i if pos.imag <= 0
      pos
    end

    def free_space_on_field(field)
      obj = { START => true, @end => true }
      @height.times do |y|
        @width.times do |x|
          pos = x + 1 + (y + 1) * 1i
          obj[pos] = true if field[pos].empty?
        end
      end
      obj
    end

    def possible_moves(pos)
      [pos] + DIFFS.map { |diff| pos + diff }
    end

    def bad_move?(pos, path, other_moves)
      (path.size == @period - 1 && path[-@period + 1] == pos) || other_moves.include?(pos)
    end

    def good_moves(path, other_moves, free_now)
      possible_moves(path.last).reject do |pos|
        !free_now[pos] || bad_move?(pos, path, other_moves)
      end
    end
  end
end
