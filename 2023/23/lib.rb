# frozen_string_literal: true

# https://adventofcode.com/2023/day/23
module Year2023
  module Day23
    STEPS = {
      "^" => Complex(-1, 0),
      ">" => Complex(0, 1),
      "v" => Complex(1, 0),
      "<" => Complex(0, -1),
    }.freeze

    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      start = Complex(0, 1)
      finish = Complex(input.size - 1, input.last.size - 2)
      path = { current: start, walk: { start => true } }
      paths = [path]
      max_length = 0
      until paths.empty?
        paths = paths.each_with_object([]) do |pth, next_paths|
          STEPS.each do |dir, diff|
            pos = pth[:current] + diff
            f = forest(input, pos)
            next if f == "#" || (f != "." && f != dir) || pth[:walk][pos]

            if pos == finish
              max_length = [max_length, pth[:walk].size].max
            else
              next_paths.push({ current: pos, walk: pth[:walk].merge(pos => true) })
            end
          end
        end
      end
      max_length
    end

    def problem2(input)
      start = Complex(0, 1)
      finish = Complex(input.size - 1, input.last.size - 2)
      path = { current: start, walk: { start => true } }
      paths = { path => true }
      max_length = 0
      puts
      until paths.empty?
        puts "#{max_length} / #{paths.size}"
        print "\e[1A"
        paths = paths.each_with_object({}) do |(pth, _), next_paths|
          STEPS.each do |_, diff|
            pos = pth[:current] + diff
            if pos == finish
              max_length = [max_length, pth[:walk].size].max
              next
            end
            next if pth[:walk][pos]
            next if forest(input, pos) == "#"
            # next unless solvable?(input, pth[:walk], pos, finish)

            npth = { current: pos, walk: pth[:walk].merge(pos => true) }
            next_paths[npth] = true
          end
        end
        # input.size.times do |r|
        #   input[r].size.times do |i|
        #     if paths.any? { |pth| pth[:walk][Complex(r, i)] }
        #       print "O"
        #     else
        #       print input[r][i]
        #     end
        #   end
        #   puts
        # end
        # puts "\e[#{input.size + 1}A"
        # sleep 0.1
      end
      max_length
    end

    private

    def forest(input, position)
      r = position.real
      i = position.imag
      return "#" if r % input.size != r || i % input.first.size != i

      input[r][i]
    end

    def solvable?(input, walk, position, finish)
      positions = [position]
      flood = { position => true }
      until positions.empty?
        positions = positions.each_with_object([]) do |pos, next_positions|
          STEPS.each do |_, diff|
            np = pos + diff
            next if flood[np] || walk[np]
            return true if np == finish
            next if forest(input, np) == "#"

            flood[np] = true
            next_positions.push(np)
          end
        end
      end
      return false
    end
  end
end
