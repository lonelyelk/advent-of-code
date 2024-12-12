# frozen_string_literal: true

# https://adventofcode.com/2024/day/12
module Year2024
  module Day12
    def process_input(str)
      lines = str.split("\n")
      ["." * (lines.first.size + 2)] + lines.map { |line| ".#{line}." } + ["." * (lines.first.size + 2)]
    end

    def problem1(input)
      measure = {}
      index = {}
      (1..(input.size - 2)).each do |y|
        (1..(input[y].size - 2)).each do |x|
          perim = 0
          code = nil
          if input[y][x] == input[y - 1][x]
            code = index[[x, y - 1]]
          else
            perim += 1
          end
          if input[y][x] == input[y][x - 1]
            if code.nil?
              code = index[[x - 1, y]]
            elsif code != index[[x - 1, y]]
              old_code = index[[x - 1, y]]
              index.keys.each do |key|
                index[key] = code if index[key] == old_code
              end
              measure[code][:area] += measure[old_code][:area]
              measure[code][:perim] += measure[old_code][:perim]
              measure.delete(old_code)
            end
          else
            perim += 1
          end
          perim += 1 if input[y][x] != input[y + 1][x]
          perim += 1 if input[y][x] != input[y][x + 1]
          code = (index.values.max || 0) + 1 if code.nil?
          index[[x, y]] = code
          measure[code] ||= { area: 0, perim: 0 }
          measure[code][:area] += 1
          measure[code][:perim] += perim
        end
      end
      measure.values.sum { |m| m[:area] * m[:perim] }
    end

    def problem2(input)
      measure = {}
      index = {}
      (1..(input.size - 2)).each do |y|
        (1..(input[y].size - 2)).each do |x|
          perim = init_perim
          code = nil
          if input[y][x] == input[y - 1][x]
            code = index[[x, y - 1]]
          else
            perim[:hor]["#{y}b"].push(x)
          end
          if input[y][x] == input[y][x - 1]
            if code.nil?
              code = index[[x - 1, y]]
            elsif code != index[[x - 1, y]]
              old_code = index[[x - 1, y]]
              index.keys.each do |key|
                index[key] = code if index[key] == old_code
              end
              measure[code][:area] += measure[old_code][:area]
              %i[hor ver].each do |dir|
                measure[old_code][:perim][dir].each do |k, v|
                  measure[code][:perim][dir][k].push(*v)
                end
              end
              measure.delete(old_code)
            end
          else
            perim[:ver]["#{x}b"].push(y)
          end
          perim[:hor]["#{y}f"].push(x) if input[y][x] != input[y + 1][x]
          perim[:ver]["#{x}f"].push(y) if input[y][x] != input[y][x + 1]
          code = (index.values.max || 0) + 1 if code.nil?
          index[[x, y]] = code
          measure[code] ||= { letter: input[y][x], area: 0, perim: init_perim }
          measure[code][:area] += 1
          %i[hor ver].each do |dir|
            perim[dir].each do |k, v|
              measure[code][:perim][dir][k].push(*v)
            end
          end
        end
      end
      measure.values.sum do |m|
        perim = m[:perim].values.sum do |hsh|
          hsh.sum do |_, arr|
            gaps = arr.sort.each_cons(2).sum do |(a, b)|
              b - a > 1 ? 1 : 0
            end
            gaps + 1
          end
        end
        perim * m[:area]
      end
    end

    def init_perim
      hor = Hash.new { |h, k| h[k] = [] }
      ver = Hash.new { |h, k| h[k] = [] }
      { hor:, ver: }
    end
  end
end
