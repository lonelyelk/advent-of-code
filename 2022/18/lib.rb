# frozen_string_literal: true

# https://adventofcode.com/2022/day/18
module Year2022
  module Day18
    POCKET_TRANS = {
      z: {
        fwd: ->(v) { v },
        bck: ->(v) { v },
      },
      y: {
        fwd: ->((x, y, z)) { [x, z, y] },
        bck: ->((x, z, y)) { [x, y, z] },
      },
      x: {
        fwd: ->((x, y, z)) { [y, z, x] },
        bck: ->((y, z, x)) { [x, y, z] },
      },
    }.freeze

    def process_input(str)
      str.scan(/(\d+),(\d+),(\d+)\n/).map { |md| md.map(&:to_i) }
    end

    def problem1(input)
      total_sides = input.size * 6
      POCKET_TRANS.each_value do |trans|
        input.map(&trans[:fwd]).sort.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
          total_sides -= 2 if x1 == x2 && y1 == y2 && z1 == z2 - 1
        end
      end
      total_sides
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def problem2(input)
      total_sides = problem1(input)
      cover = POCKET_TRANS.keys.each_with_object({}) { |key, acc| acc[key] = [] }
      POCKET_TRANS.each do |key, trans|
        input.map(&trans[:fwd]).sort.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
          next unless x1 == x2 && y1 == y2 && z2 - z1 > 1

          cover[key].push(((z1 + 1)...z2).map { |z| [x1, y1, z] }.map(&trans[:bck]))
        end
      end
      flat_cover_y = cover[:y].flatten(1)
      flat_cover_z = cover[:z].flatten(1)
      cover[:x].select! { |pocket| pocket.all? { |cube| flat_cover_y.include?(cube) && flat_cover_z.include?(cube) } }
      flat_cover_x = cover[:x].flatten(1)
      cover[:y].select! { |pocket| pocket.all? { |cube| flat_cover_x.include?(cube) && flat_cover_z.include?(cube) } }
      flat_cover_y = cover[:y].flatten(1)
      cover[:z].select! { |pocket| pocket.all? { |cube| flat_cover_x.include?(cube) && flat_cover_y.include?(cube) } }
      air_cubes = cover[:z].flatten(1)
      total_sides - problem1(air_cubes)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  end
end
