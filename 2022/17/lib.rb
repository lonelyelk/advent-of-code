# frozen_string_literal: true

# https://adventofcode.com/2022/day/17
module Year2022
  module Day17
    ROCKS = [
      %w[####],
      %w[.#. ### .#.],
      %w[### ..# ..#],
      %w[# # # #],
      %w[## ##],
    ]
    def process_input(str)
      str.chomp
    end

    def problem1(input, max_rocks = 2022)
      width = 7
      top = 0
      d_top = 0
      @wind = 0
      pipe = []
      @rock_index = 0
      rock = get_rock
      x = 2
      y = top + 3
      c_rocks = 1
      cache = {}
      magic_state = nil
      loop do
        dx = blow(input)
        new_x = x + dx
        if dx.positive?
          if new_x + rock.first.size <= width &&
            rock.each_with_index.all? { |l, i| pipe[y + i].nil? || pipe[y + i][new_x + l.rindex(?#)] != ?# }
            x = new_x
          end
        else
          if new_x >= 0 &&
            rock.each_with_index.all? { |l, i| pipe[y + i].nil? || pipe[y + i][new_x + l.index(?#)] != ?# }
            x = new_x
          end
        end
        if y.positive? && (pipe[y - 1].nil? || rock.each_with_index.all?{ |l, i| l.chars.each_with_index.all? { |c, n| pipe[y + i - 1].nil? || c != ?# || pipe[y + i - 1][x + n] != ?# } })
          y -= 1
        else
          rock.each_with_index do |l, i|
            pipe[y + i] ||= ?. * width
            l.chars.each_with_index { |c, n| c == ?# && pipe[y + i][x + n] = c }
          end
          if d_top == 0 && @rock_index == 1 && y == top && (1..2).cover?(x)
            key = "#{@wind},#{x}"
            if cache[key]
              rocks_period = c_rocks - cache[key][:c_rocks]
              n_periods = (max_rocks - c_rocks) / rocks_period
              d_rocks = rocks_period * n_periods
              if c_rocks + d_rocks <= max_rocks
                c_rocks += d_rocks
                d_top = (top - cache[key][:top]) * n_periods
              end
            else
              cache[key] = { top:, c_rocks: }
            end
          end
          top = [y + rock.size, top].max
          rock = get_rock
          c_rocks += 1
          x = 2
          y = top + 3
          return top + d_top if c_rocks > max_rocks
        end
      end
      top
    end

    def problem2(input)
      problem1(input, 1000000000000)
    end

    private

    def blow(input)
      out = input[@wind] == ?< ? -1 : 1
      @wind += 1
      @wind %= input.size
      out
    end

    def get_rock
      out = ROCKS[@rock_index]
      @rock_index += 1
      @rock_index %= ROCKS.size
      out
    end

    def print_pipe(top, x, y, rock, dx, pipe)
      w = dx.positive? ? ?> : ?<
      puts
      puts w
      puts
      (([top + rock.size + 3 - 30, 0].max)...(top + rock.size + 3)).to_a.reverse.each do |yy|
        l = ?. * 7
        if (0...rock.size).include?(yy - y)
          rock[yy - y].chars.each_with_index { |c, i| c == ?# && l[i + x] = w }
        end
        if pipe[yy]
          pipe[yy].chars.each_with_index { |c, i| c == ?# && l[i] = ?# }
        end
        puts l
      end
      puts
    end
  end
end
