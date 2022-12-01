# frozen_string_literal: true

# https://adventofcode.com/2021/day/25
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
module Day25
  def process_input(str)
    lines = str.split("\n").reject(&:empty?)
    @height = lines.size
    (0...@height).each_with_object(east: {}, south: {}) do |y, acc|
      line = lines[y].chars
      @width ||= line.size
      (0...@width).each do |x|
        case line[x]
        when ">"
          acc[:east][[x, y]] = true
        when "v"
          acc[:south][[x, y]] = true
        end
      end
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def problem1(input)
    state = input
    frame = [@width, @height]
    directions = %i[east south]
    (1..).each do |move|
      next_state = { east: {}, south: {} }
      moved = 0
      directions.each_with_index do |dir, i|
        state[dir].each do |coord, _|
          new_coord = coord.dup
          new_coord[i] += 1
          new_coord[i] = 0 if new_coord[i] >= frame[i]
          if (directions[i + 1] && state.any? { |_, places| places[new_coord] }) ||
             (i.positive? && (state[directions[i]][new_coord] || next_state[directions[i - 1]][new_coord]))
            next_state[dir][coord] = true
          else
            moved += 1
            next_state[dir][new_coord] = true
          end
        end
      end

      return move if moved.zero?

      state = next_state
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
