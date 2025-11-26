# frozen_string_literal: true

# https://adventofcode.com/2023/day/13
module Year2023
  module Day13
    def process_input(str)
      str.split("\n\n").reject(&:empty?).map do |section|
        section.split("\n").reject(&:empty?)
      end
    end

    def problem1(input)
      input.sum do |section|
        if (mirror_row = find_edge(section))
          mirror_row * 100
        else
          t_section = section.map(&:chars).transpose.map(&:join)
          find_edge(t_section)
        end
      end
    end

    def problem2(input)
      input.sum do |section|
        if (mirror_row = find_edge_with_smudge(section))
          mirror_row * 100
        else
          t_section = section.map(&:chars).transpose.map(&:join)
          find_edge_with_smudge(t_section)
        end
      end
    end

    private

    def find_edge(section)
      (1...section.size).to_a.detect do |row|
        part, reflection = reflected_parts(section, row)
        part == reflection
      end
    end

    def find_edge_with_smudge(section)
      (1...section.size).to_a.detect do |row|
        part, reflection = reflected_parts(section, row)
        part.join.chars.zip(reflection.join.chars).one? { |c1, c2| c1 != c2 }
      end
    end

    def reflected_parts(section, row)
      size =
        if row * 2 > section.size
          section.size - row
        else
          row
        end
      [section[(row - size), size], section[row, size].reverse]
    end
  end
end
