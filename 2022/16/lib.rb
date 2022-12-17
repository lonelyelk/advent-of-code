# frozen_string_literal: true

# https://adventofcode.com/2022/day/16
module Year2022
  module Day16
    def process_input(str)
      str
        .scan(/Valve ([A-Z]+) has flow rate=(\d+); tunnels? leads? to valves? ([A-Z, ]+)/)
        .each_with_object({}) do |(v, r, other), acc|
          acc[v] = { rate: r.to_i, valves: other.split(", ") }
        end
    end

    def problem1(input)
      state, openable = init(input)
      state = make_move(input, state, openable)
      state[:rate]
    end

    def problem2(input)
      state, openable = init(input)
      rate = 0
      openable.combination(openable.size / 2) do |open_half|
        rate_me = make_move(input, state, open_half, 26)[:rate]
        rate_elephant = make_move(input, state, openable - open_half, 26)[:rate]
        rate = [rate_me + rate_elephant, rate].max
      end
      rate
    end

    private

    def init(input)
      @paths = {}
      state = { valve: "AA", open: [], rate: 0, time: 0 }
      openable = input.reject { |_, v| v[:rate].zero? }.keys
      [state, openable]
    end

    def filter_cached_paths(valve, target)
      @paths[valve].select { |k, _| target.include?(k) }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def make_graph(input, target, valve)
      return filter_cached_paths(valve, target) if @paths.key?(valve)

      @paths[valve] = { valve => 0 }
      until input.keys.all? { |t| @paths[valve].keys.include?(t) }
        @paths[valve] = @paths[valve].each_with_object(@paths[valve].dup) do |(vlv, dt), acc|
          input[vlv][:valves].each do |v|
            acc[v] = dt + 1 if acc[v].nil? || acc[v] > dt + 1
          end
        end
      end
      filter_cached_paths(valve, target)
    end

    # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity
    def make_move(input, state, openable, max_time = 30)
      return state if state[:time] >= max_time

      return advance_time(input, state, max_time - state[:time]) if (openable - state[:open]).empty?

      if !openable.include?(state[:valve]) || state[:open].include?(state[:valve])
        graph = make_graph(input, openable - state[:open], state[:valve])
        states = graph.map do |valve, dt|
          if state[:time] + dt <= max_time
            s = advance_time(input, state, dt)
            make_move(input, s.merge(valve:), openable, max_time)
          else
            advance_time(input, state, max_time - state[:time])
          end
        end
        states.max_by { |s| s[:rate] }
      else
        state = advance_time(input, state)
        make_move(input, state.merge(open: state[:open] + [state[:valve]]), openable, max_time)
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    def advance_time(input, state, delta_t = 1)
      state.merge(
        time: state[:time] + delta_t,
        rate: state[:rate] + delta_t * state[:open].inject(0) { |acc, v| acc + input[v][:rate] }
      )
    end
  end
end
