# frozen_string_literal: true

# https://adventofcode.com/2023/day/21
module Year2023
  module Day21
    STEPS = [Complex(0, 1), Complex(0, -1), Complex(1, 0), Complex(-1, 0)].freeze

    def process_input(str)
      lines = str.split("\n")
      lines.each_with_index.inject({ garden: {}, r_size: lines.size, i_size: lines.first.size }) do |acc, (line, r)|
        line.chars.each_with_index.with_object(acc) do |(c, i), g|
          g[:garden][Complex(r, i)] = true if c == "#"
          g[:start] = Complex(r, i) if c == "S"
        end
      end
    end

    def problem1(input, steps = 64)
      set_boundaries(input)
      steps.times.inject({ input[:start] => true }) do |positions, _|
        positions.each_with_object({}) do |(pos, _), np|
          STEPS.each do |diff|
            n = pos + diff
            np[n] = true unless input[:garden][n]
          end
        end
      end.keys.size
    end

    def problem2(input, steps = 26_501_365)
      cache = {}
      cached = {}
      true_cache = {}
      init = init_garden
      init[0i] = { input[:start] => true }
      steps.times.inject(init) do |positions, step|
        p [step, positions.size, cached.size, cache.size, true_cache.size]
        # (-input[:r_size]..(input[:r_size]*2 - 2)).each do |r|
        #   (-input[:i_size]..(input[:i_size]*2 - 2)).each do |i|
        #     grid_r, pos_r = r.divmod(input[:r_size])
        #     grid_i, pos_i = i.divmod(input[:i_size])
        #     grid = Complex(grid_r, grid_i)
        #     pos = Complex(pos_r, pos_i)
        #     if input[:garden][pos]
        #       print "#"
        #     elsif positions.key?(grid) && positions[grid][pos]
        #       print "O"
        #     else
        #       print "."
        #     end
        #   end
        #   puts
        # end
        # puts
        # sleep 1
        positions.each_with_object(init_garden) do |(grid, inner_positions), np|
          # if cache[inner_positions] && cache[cache[inner_positions]] != cache[inner_positions]
          # end
          key = cache_key(positions, grid)
          # if true_cache[key]
          #   np[grid] = true_cache[key]
          #   cached[grid] = true
          if cache[key] # && cache[cache[key]] == inner_positions
            # true_cache[key] = np[grid] = cache[key]
            np[grid] = cache[key][:inner]
            cached[grid] = true
            cache[key][:outer].each do |g, cached_pos|
              next if cached[grid + g]
              cached_pos.each { |pos, _| np[grid + g][pos] = true }
            end
          else
            outer = init_garden
            inner_positions.each do |pos, _|
              STEPS.each do |diff|
                z = pos + diff
                grid_r, pos_r = z.real.divmod(input[:r_size])
                grid_i, pos_i = z.imag.divmod(input[:i_size])
                n_grid = grid + Complex(grid_r, grid_i)
                n_pos = Complex(pos_r, pos_i)
                next if input[:garden][n_pos] || cached[n_grid]

                np[n_grid][n_pos] = true
                outer[n_grid - grid][n_pos] = true unless grid == n_grid
              end
            end
            # if cache[key] && cache[key] != np[grid]
            #   (0...input[:r_size]).each do |r|
            #     (0...input[:i_size]).each do |i|
            #       pos = Complex(r, i)
            #       if input[:garden][pos]
            #         print "#"
            #       elsif np[grid][pos] && !cache[inner_positions][pos]
            #         print "N"
            #       elsif !np[grid][pos] && cache[inner_positions][pos]
            #         print "O"
            #       elsif np[grid][pos]
            #         print "="
            #       else
            #         print "."
            #       end
            #     end
            #     puts "  = #{grid}"
            #   end
            #   puts
            #   sleep 1
            # end
            cache[key] = {inner: np[grid], outer: }
          end
        end
      end.values.sum { |v| v.size }
    end

    private

    def set_boundaries(garden)
      (-1..garden[:r_size]).each { |r| garden[:garden][Complex(r, -1)] = garden[:garden][Complex(r, garden[:i_size])] = true }
      (-1..garden[:i_size]).each { |i| garden[:garden][Complex(-1, i)] = garden[:garden][Complex(garden[:r_size], i)] = true }
    end

    def init_garden
      Hash.new { |h, k| h[k] = {} }
    end

    def cache_key(garden, grid)
      # garden[grid]
      [garden[grid], *STEPS.map { |d| garden.key?(grid + d) && garden[grid + d] }]
    end
  end
end
