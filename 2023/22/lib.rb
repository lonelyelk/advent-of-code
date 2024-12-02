# frozen_string_literal: true

# https://adventofcode.com/2023/day/22
module Year2023
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  module Day22
    def process_input(str)
      str.split("\n").map do |line|
        md = line.match(/(\d+),(\d+),(\d+)~(\d+),(\d+),(\d+)/)
        [[md[1], md[4]], [md[2], md[5]], [md[3], md[6]]].map { |a| a.map(&:to_i).sort }
      end
    end

    def problem1(input)
      settled, supported_by, supports = settle(input.sort_by { |(_, _, z)| z.first })
      settled.count do |brick|
        supported_by[brick].nil? || supported_by[brick].all? do |falling_brick, _|
          supports[falling_brick].nil? || supports[falling_brick].size > 1
        end
      end
    end

    def problem2(input)
      _, supported_by, supports = settle(input.sort_by { |(_, _, z)| z.first })
      supported_by.sum do |brick, supported_bricks|
        des_bricks = { brick => true }
        falling_bricks = supported_bricks.reject { |sb, _| supports[sb].any? { |b, _| !des_bricks[b] } }
        until falling_bricks.empty?
          des_bricks.merge!(falling_bricks)
          falling_bricks = falling_bricks.each_with_object({}) do |(falling_brick, _), chain_falling|
            next if supported_by[falling_brick].nil?

            really_falling = supported_by[falling_brick].reject { |sb, _| supports[sb].any? { |b, _| !des_bricks[b] } }
            chain_falling.merge!(really_falling)
          end
        end
        des_bricks.size - 1
      end
    end

    private

    def settle(source_stack)
      source_stack.each_with_object([[], {}, {}]) do |(x, y, z), (stack, supported_by, supports)|
        z_max, support = z_max_for([x, y, z], stack)
        brick = [x, y, [z_max + 1, z_max + 1 + z.last - z.first]]
        supports[brick] = support.to_h { |b| [b, true] }
        support.each do |sb|
          supported_by[sb] ||= {}
          supported_by[sb][brick] = true
        end
        stack.push(brick)
      end
    end

    def z_max_for(brick, stack)
      x, y, = brick
      stack.inject([0, []]) do |acc, (sx, sy, sz)|
        if sx.first <= x.last && x.first <= sx.last && sy.first <= y.last && y.first <= sy.last && sz.last >= acc.first
          sz.last == acc.first ? [sz.last, [*acc.last, [sx, sy, sz]]] : [sz.last, [[sx, sy, sz]]]
        else
          acc
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
end
