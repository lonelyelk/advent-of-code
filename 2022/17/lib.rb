# frozen_string_literal: true

# https://adventofcode.com/2022/day/17
module Year2022
  module Day17
    ROCKS = [
      %w[####].freeze,
      %w[.#. ### .#.].freeze,
      %w[### ..# ..#].freeze,
      %w[# # # #].freeze,
      %w[## ##].freeze,
    ].freeze

    WIDTH = 7

    def process_input(str)
      str.chomp
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def problem1(input, max_rocks = 2022)
      init!
      loop do
        dx = blow!(input)
        @x += dx if x_move_allowed?(@x + dx)

        if @y.positive? && (@pipe[@y - 1].nil? || move_allowed?(@x, @y - 1))
          @y -= 1
        else
          land_rock!
          optimize!(max_rocks)
          @top = [@y + @rock.size, @top].max
          next_rock!
          return @top + @delta_top if @c_rocks > max_rocks
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def problem2(input)
      problem1(input, 1_000_000_000_000)
    end

    private

    def init!
      @wind = 0
      @pipe = []
      @rock_index = 0
      @c_rocks = 0
      @top = 0
      @delta_top = 0
      @cache = {}
      next_rock!
    end

    def blow!(input)
      out = input[@wind %= input.size] == ?< ? -1 : 1
      @wind += 1
      out
    end

    def next_rock!
      @rock = ROCKS[@rock_index %= ROCKS.size]
      @rock_index += 1
      @c_rocks += 1
      @x = 2
      @y = @top + 3
    end

    def x_move_allowed?(new_x)
      new_x + @rock.first.size <= WIDTH && new_x >= 0 && move_allowed?(new_x, @y)
    end

    def move_allowed?(new_x, new_y)
      @rock.each_with_index.all? do |line, i|
        @pipe[new_y + i].nil? ||
          line.chars.each_with_index.all? { |c, n| c != ?# || @pipe[new_y + i][new_x + n] != ?# }
      end
    end

    def land_rock!
      @rock.each_with_index do |l, i|
        @pipe[@y + i] ||= ?. * WIDTH
        l.chars.each_with_index { |c, n| c == ?# && @pipe[@y + i][@x + n] = c }
      end
    end

    def magic_rock?
      @delta_top.zero? && @rock_index == 1 && @y == @top && (1..2).cover?(@x)
    end

    def optimize!(max_rocks)
      return unless magic_rock?

      key = "#{@wind},#{@x}"
      if @cache[key]
        rocks_period = @c_rocks - @cache[key][:rocks]
        n_periods = (max_rocks - @c_rocks) / rocks_period
        @c_rocks += rocks_period * n_periods
        @delta_top = (@top - @cache[key][:top]) * n_periods
      else
        @cache[key] = { top: @top, rocks: @c_rocks }
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def print_pipe(input)
      puts "\n#{input[@wind]}\n"
      y_range_reversed.each do |yy|
        l = ?. * WIDTH
        if (0...@rock.size).include?(yy - @y)
          @rock[yy - @y].chars.each_with_index { |c, i| c == ?# && l[i + @x] = input[@wind] }
        end
        @pipe[yy]&.chars&.each_with_index { |c, i| c == ?# && l[i] = ?# }
        puts l
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def y_range_reversed
      (([@top + @rock.size + 3 - 30, 0].max)...(@top + @rock.size + 3)).to_a.reverse
    end
  end
end
