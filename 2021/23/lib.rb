# frozen_string_literal: true

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
        next if HOMES[a] == place && (d == state.size - 2 || ((d + 1)..(state.size - 2)).all? { |dd| HOMES[state[dd][i]] == place })

        [:left, :right].each do |dir|
          MOVES_OUT[place][dir].each do |hall_pos, cost|
            break unless state[0][hall_pos].nil?

            next_hall = state[0].dup
            next_hall[hall_pos] = a
            next_states = state[1, state.size - 2].map(&:dup)
            next_states[d - 1][i] = nil
            possible.push([next_hall, *next_states, (cost + d - 1) * COSTS[a]])
          end
        end
      end
    end
    state[0].each_with_index do |a, i|
      next if a.nil?

      home = HOMES[a]
      pos = home / 2 - 1
      next if !state[1][pos].nil?
      next if (2..(state.size - 2)).any? { |dd| state[dd][pos] != a && !state[dd][pos].nil? }

      path = state[0][([i + 1, home].min)..([i - 1, home].max)]
      next if path.any?

      cost = path.size + 1
      d = ((1..(state.size - 2)).detect { |dd| !state[dd][pos].nil? } || state.size - 1) - 2
      next_hall = state[0].dup
      next_hall[i] = nil
      next_states = state[1, state.size - 2].map(&:dup)
      next_states[d][pos] = a
      possible.push([next_hall, *next_states, (cost + d) * COSTS[a]])
    end
    possible
  end

  def find_solutions(input)
    possible_moves(input).each_with_object([]) do |move, acc|
      if move[0].all?(&:nil?)
        acc.push move.last
      else
        key = move[0..2].inject(&:+)
        @cache[key] ||= find_solutions(move)
        acc.concat(@cache[key].map { |c| c + move.last })
      end
    end
  end

  def problem1(input)
    @cache = {}
    solutions = find_solutions(input)

    solutions.min
  end

  def problem2(input)
  end
end
