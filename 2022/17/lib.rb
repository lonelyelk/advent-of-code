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

    def problem1(input, max_rocks = 2022)
      init!
      loop do
        dx = blow!(input)
        new_x = @x + dx
        if dx.positive?
          if new_x + @rock.first.size <= WIDTH &&
            @rock.each_with_index.all? { |l, i| @pipe[@y + i].nil? || @pipe[@y + i][new_x + l.rindex(?#)] != ?# }
            @x = new_x
          end
        else
          if new_x >= 0 &&
            @rock.each_with_index.all? { |l, i| @pipe[@y + i].nil? || @pipe[@y + i][new_x + l.index(?#)] != ?# }
            @x = new_x
          end
        end
        if @y.positive? && (@pipe[@y - 1].nil? || @rock.each_with_index.all?{ |l, i| l.chars.each_with_index.all? { |c, n| @pipe[@y + i - 1].nil? || c != ?# || @pipe[@y + i - 1][@x + n] != ?# } })
          @y -= 1
        else
          @rock.each_with_index do |l, i|
            @pipe[@y + i] ||= ?. * WIDTH
            l.chars.each_with_index { |c, n| c == ?# && @pipe[@y + i][@x + n] = c }
          end
          optimize!(max_rocks)
          @top = [@y + @rock.size, @top].max
          next_rock!
          if @c_rocks > max_rocks
            print_pipe(input)
            return @top + @delta_top
          end
        end
      end
    end

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
      out = input[@wind] == ?< ? -1 : 1
      @wind += 1
      @wind %= input.size
      out
    end

    def next_rock!
      @rock = ROCKS[@rock_index]
      @rock_index += 1
      @rock_index %= ROCKS.size
      @c_rocks += 1
      @x = 2
      @y = @top + 3
    end

    def optimize!(max_rocks)
      return if @delta_top.positive? || @rock_index != 1 || @y != @top || !(1..2).cover?(@x)

      key = "#{@wind},#{@x}"
      if @cache[key]
        rocks_period = @c_rocks - @cache[key][:rocks]
        n_periods = (max_rocks - @c_rocks) / rocks_period
        d_rocks = rocks_period * n_periods
        if @c_rocks + d_rocks <= max_rocks
          @c_rocks += d_rocks
          @delta_top = (@top - @cache[key][:top]) * n_periods
        end
      else
        @cache[key] = { top: @top, rocks: @c_rocks }
      end
    end

    def print_pipe(input)
      puts
      puts input[@wind]
      puts
      (([@top + @rock.size + 3 - 30, 0].max)...(@top + @rock.size + 3)).to_a.reverse.each do |yy|
        l = ?. * WIDTH
        if (0...@rock.size).include?(yy - @y)
          @rock[yy - @y].chars.each_with_index { |c, i| c == ?# && l[i + @x] = input[@wind] }
        end
        @pipe[yy].chars.each_with_index { |c, i| c == ?# && l[i] = ?# } if @pipe[yy]
        puts l
      end
      puts
    end
  end
end
