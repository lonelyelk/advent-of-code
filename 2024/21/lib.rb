# frozen_string_literal: true

# https://adventofcode.com/2024/day/21
module Year2024
  module Day21
    ARROWS = {
      "A" => 2 + 0i,
      "^" => 1 + 0i,
      "<" => 0 + 1i,
      "v" => 1 + 1i,
      ">" => 2 + 1i,
    }.freeze
    DIRECTIONS = {
      -1i => "^",
      -1 + 0i => "<",
      1i => "v",
      1 + 0i => ">",
    }.freeze
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

    def problem1(input)
      input.sum do |sequence|
        pos = NUMBERS["A"]
        acc = 0
        sequence.chars.each do |c|
          diff = NUMBERS[c] - pos
          seqs = sequences_for(diff)
          seqs = seqs.reject do |seq|
            pass_hole = false
            pos_test = pos
            seq[...-1].chars.each do |mvm|
              pos_test += DIRECTIONS.key(mvm)
              pass_hole = true if NUMBERS.key(pos_test).nil?
            end
            pass_hole
          end
          lens = seqs.each_with_object({}) do |seq, len_acc|
            len_acc[seq] = "A#{seq}".chars.each_cons(2).sum do |pair|
              step_cost2[pair.join]
            end
          end
          acc += lens.values.min
          pos += diff
        end
        acc * sequence[...-1].to_i
      end
    end

    def problem2(input)
      input.sum do |sequence|
        pos = NUMBERS["A"]
        acc = 0
        sequence.chars.each do |c|
          diff = NUMBERS[c] - pos
          seqs = sequences_for(diff)
          seqs = seqs.reject do |seq|
            pass_hole = false
            pos_test = pos
            seq[...-1].chars.each do |mvm|
              pos_test += DIRECTIONS.key(mvm)
              pass_hole = true if NUMBERS.key(pos_test).nil?
            end
            pass_hole
          end
          lens = seqs.each_with_object({}) do |seq, len_acc|
            len_acc[seq] = "A#{seq}".chars.each_cons(2).sum do |pair|
              step_cost25[pair.join]
            end
          end
          acc += lens.values.min
          pos += diff
        end
        acc * sequence[...-1].to_i
      end
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

    def sequences_for(diff)
      dx = diff.real
      dy = diff.imag
      dxseq = DIRECTIONS[Complex(dx / dx.abs, 0)] * dx.abs unless dx.zero?
      dyseq = DIRECTIONS[Complex(0, dy / dy.abs)] * dy.abs unless dy.zero?
      "#{dxseq}#{dyseq}".chars.permutation.to_a.uniq.map { |perm| "#{perm.join}A" }
    end
  end
end
