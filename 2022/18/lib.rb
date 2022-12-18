# frozen_string_literal: true

# https://adventofcode.com/2022/day/18
module Year2022
  module Day18
    def process_input(str)
      str.scan(/(\d+),(\d+),(\d+)\n/).map { |md| md.map(&:to_i) }
    end

    def problem1(input)
      total_sides = input.size * 6
      input.sort.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
        total_sides -= 2 if x1 == x2 && y1 == y2 && z1 == z2 - 1
      end
      input.sort_by { |(x, y, z)| [x, z, y] }.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
        total_sides -= 2 if x1 == x2 && z1 == z2 && y1 == y2 - 1
      end
      input.sort_by { |(x, y, z)| [y, z, x] }.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
        total_sides -= 2 if z1 == z2 && y1 == y2 && x1 == x2 - 1
      end
      total_sides
    end

    def problem2(input)
      total_sides = input.size * 6
      cover_x = []
      cover_y = []
      cover_z = []
      input.sort.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
        next unless x1 == x2 && y1 == y2

        if z2 - z1 == 1
          total_sides -= 2
        else
          cover_z.push(((z1 + 1)...z2).map { |z| [x1, y1, z] })
        end
      end
      input.sort_by { |(x, y, z)| [x, z, y] }.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
        next unless x1 == x2 && z1 == z2

        if y2 - y1 == 1
          total_sides -= 2
        else
          cover_y.push(((y1 + 1)...y2).map { |y| [x1, y, z1] })
        end
      end
      input.sort_by { |(x, y, z)| [y, z, x] }.each_cons(2) do |(x1, y1, z1), (x2, y2, z2)|
        next unless z1 == z2 && y1 == y2

        if x2 - x1 == 1
          total_sides -= 2
        else
          cover_x.push(((x1 + 1)...x2).map { |x| [x, y1, z1] })
        end
      end
      flat_cover_y = cover_y.flatten(1)
      flat_cover_z = cover_z.flatten(1)
      cover_x.select! { |pocket| pocket.all? { |cube| flat_cover_y.include?(cube) && flat_cover_z.include?(cube) } }
      flat_cover_x = cover_x.flatten(1)
      cover_y.select! { |pocket| pocket.all? { |cube| flat_cover_x.include?(cube) && flat_cover_z.include?(cube) } }
      flat_cover_y = cover_y.flatten(1)
      cover_z.select! { |pocket| pocket.all? { |cube| flat_cover_x.include?(cube) && flat_cover_y.include?(cube) } }
      air_cubes = cover_z.flatten(1)
      total_sides -= problem1(air_cubes)
      total_sides
    end
  end
end
