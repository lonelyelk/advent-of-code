# frozen_string_literal: true

# https://adventofcode.com/2021/day/23
# rubocop:disable Metrics/ModuleLength, Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Day23
  HALL = [0, 1, 3, 5, 7, 9, 10].freeze
  COSTS = {
    A: 1,
    B: 10,
    C: 100,
    D: 1000,
  }.freeze
  MOVES_OUT = {
    2 => {
      left: {
        1 => 2,
        0 => 3,
      }.freeze,
      right: {
        3 => 2,
        5 => 4,
        7 => 6,
        9 => 8,
        10 => 9,
      }.freeze,
    },
    4 => {
      left: {
        3 => 2,
        1 => 4,
        0 => 5,
      }.freeze,
      right: {
        5 => 2,
        7 => 4,
        9 => 6,
        10 => 7,
      }.freeze,
    },
    6 => {
      left: {
        5 => 2,
        3 => 4,
        1 => 6,
        0 => 7,
      }.freeze,
      right: {
        7 => 2,
        9 => 4,
        10 => 5,
      }.freeze,
    },
    8 => {
      left: {
        7 => 2,
        5 => 4,
        3 => 6,
        1 => 8,
        0 => 9,
      }.freeze,
      right: {
        9 => 2,
        10 => 3,
      }.freeze,
    },
  }.freeze
  HOMES = {
    A: 2,
    B: 4,
    C: 6,
    D: 8,
  }.freeze

  def process_input(str)
    str.split("\n").each_with_object([Array.new(11)]) do |line, acc|
      if (md = line.match(/#(\w)#(\w)#(\w)#(\w)#/))
        acc.push(md[1, 4].map(&:to_sym))
      end
    end + [0]
  end

  def possible_moves(state)
    possible = []
    (1..(state.size - 2)).each do |d|
      state[d].each_with_index do |a, i|
        next if a.nil?
        next if d > 1 && (1...d).any? { |dd| !state[dd][i].nil? }

        place = (i + 1) * 2
        if HOMES[a] == place && (d == state.size - 2 || ((d + 1)..(state.size - 2)).all? do |dd|
                                   HOMES[state[dd][i]] == place
                                 end)
          next
        end

        %i[left right].each do |dir|
          MOVES_OUT[place][dir].each do |hall_pos, cost|
            break unless state[0][hall_pos].nil?

            next_hall = state[0].dup
            next_hall[hall_pos] = a
            next_states = state[1, state.size - 2].map(&:dup)
            next_states[d - 1][i] = nil
            cost = (cost + d - 1) * COSTS[a]
            possible.push([next_hall, *next_states, cost])
          end
        end
      end
    end
    state[0].each_with_index do |a, i|
      next if a.nil?

      home = HOMES[a]
      pos = home / 2 - 1
      next unless state[1][pos].nil?
      next if (2..(state.size - 2)).any? { |dd| state[dd][pos] != a && !state[dd][pos].nil? }

      path = state[0][([i + 1, home].min)..([i - 1, home].max)]
      next if path.any?

      cost = path.size + 1
      d = ((1..(state.size - 2)).detect { |dd| !state[dd][pos].nil? } || state.size - 1) - 2
      next_hall = state[0].dup
      next_hall[i] = nil
      next_states = state[1, state.size - 2].map(&:dup)
      next_states[d][pos] = a
      cost = (cost + d) * COSTS[a]
      possible.push([next_hall, *next_states, cost])
    end
    possible
  end

  def find_solutions(input, cost_so_far = 0)
    possible_moves(input).each_with_object([]) do |move, acc|
      if move[0].all?(&:nil?)
        acc.push move.last
        @costs.push(cost_so_far + move.last)
      elsif @costs.empty? || cost_so_far + move.last < @costs.min
        key = move[0, move.size - 1].inject(&:+)
        if !@cache.key?(key) || @cache[key][:cost] > cost_so_far
          @cache[key] = {
            cost: cost_so_far,
            solutions: find_solutions(move, cost_so_far + move.last),
          }
        end
        acc.concat(@cache[key][:solutions].map { |c| c + move.last })
      end
    end
  end

  def problem1(input)
    @cache = {}
    @costs = []
    find_solutions(input).min
  end

  def problem2(input)
    unfolded = input[0, 2] + [%i[D C B A], %i[D B A C]] + input[2..]
    @cache = {}
    @costs = []
    find_solutions(unfolded).min
  end
end
# rubocop:enable Metrics/ModuleLength, Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
