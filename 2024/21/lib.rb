# frozen_string_literal: true

# https://adventofcode.com/2024/day/21
module Year2024
  module Day21
    DIRECTIONS = { -1i => "^", -1 + 0i => "<", 1i => "v", 1 + 0i => ">" }.freeze
    NUMBERS = {
      "7" => 0 + 0i,
      "8" => 1 + 0i,
      "9" => 2 + 0i,
      "4" => 0 + 1i,
      "5" => 1 + 1i,
      "6" => 2 + 1i,
      "1" => 0 + 2i,
      "2" => 1 + 2i,
      "3" => 2 + 2i,
      "0" => 1 + 3i,
      "A" => 2 + 3i,
    }.freeze
    MOVEMENTS = {
      "^^" => "A",
      "^>" => "v>A",
      "^<" => "v<A",
      "^A" => ">A",
      ">^" => "<^A",
      ">>" => "A",
      ">v" => "<A",
      ">A" => "^A",
      "v>" => ">A",
      "vv" => "A",
      "v<" => "<A",
      "vA" => "^>A",
      "<^" => ">^A",
      "<v" => ">A",
      "<<" => "A",
      "<A" => ">>^A",
      "A^" => "<A",
      "A>" => "vA",
      "Av" => "<vA",
      "A<" => "v<<A",
      "AA" => "A",
    }.freeze

    def process_input(str)
      str.split("\n")
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def problem1(input, step_cost = step_cost2)
      input.sum do |sequence|
        pos = NUMBERS["A"]
        length = sequence.chars.sum do |c|
          diff = NUMBERS[c] - pos
          seqs = sequences_for(diff).reject do |seq|
            pass_over_hole?(seq, pos)
          end
          lens = seqs.each_with_object({}) do |seq, len_acc|
            len_acc[seq] = "A#{seq}".chars.each_cons(2).sum do |pair|
              step_cost[pair.join]
            end
          end
          pos += diff
          lens.values.min
        end
        length * sequence[...-1].to_i
      end
    end
    # rubocop:enable Metrics/MethodLength

    def sequences_for(diff)
      dx, dy = diff.rect
      dxa = dx.abs
      dya = dy.abs
      dxseq = DIRECTIONS[Complex(dx / dxa, 0)] * dxa unless dx.zero?
      dyseq = DIRECTIONS[Complex(0, dy / dya)] * dya unless dy.zero?
      "#{dxseq}#{dyseq}".chars.permutation.uniq.map { |perm| "#{perm.join}A" }
    end
    # rubocop:enable Metrics/AbcSize

    def problem2(input)
      problem1(input, step_cost25)
    end

    def resolve_sequences(movements, resolution = MOVEMENTS)
      movements.transform_values do |seq|
        seq.size.times.map { |i| resolution["#{seq[i - 1]}#{seq[i]}"] }.join
      end
    end

    def count_sequences(movements, resolution = MOVEMENTS)
      movements.transform_values do |seq|
        seq.size.times.sum { |i| resolution["#{seq[i - 1]}#{seq[i]}"].size }
      end
    end

    def step_cost2
      return @step_cost2 if @step_cost2

      @step_cost2 = count_sequences(MOVEMENTS)
    end

    def step_cost25
      return @step_cost25 if @step_cost25

      step = resolve_sequences(MOVEMENTS)
      10.times { step = resolve_sequences(step) }
      step13 = resolve_sequences(step)
      @step_cost25 = count_sequences(step13, step)
    end

    def pass_over_hole?(sequence, position)
      sequence[...-1].chars.any? do |mvm|
        position += DIRECTIONS.key(mvm)
        NUMBERS.key(position).nil?
      end
    end
  end
end
