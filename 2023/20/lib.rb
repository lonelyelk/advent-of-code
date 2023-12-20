# frozen_string_literal: true

# https://adventofcode.com/2023/day/20
module Year2023
  module Day20
    class FlipFlop
      attr_reader :name, :inputs, :outputs

      def initialize(name:, outputs:)
        @name = name[1..]
        @state = :off
        @outputs = outputs
      end

      def init_inputs(_inputs); end

      def receive(pulse, _input)
        return [] if pulse == :high

        @state = @state == :off ? :on : :off
        @outputs.map { |n| [@name, @state == :on ? :high : :low, n] }
      end
    end

    class Conjunction
      attr_reader :name, :outputs

      def initialize(name:, outputs:)
        @name = name[1..]
        @outputs = outputs
      end

      def init_inputs(inputs)
        @states = inputs.to_h { |n| [n, :low] }
      end

      def receive(pulse, input)
        @states[input] = pulse
        out_pulse = @states.values.all?(:high) ? :low : :high
        @outputs.map { |n| [@name, out_pulse, n] }
      end
    end

    class Broadcaster
      attr_reader :name, :outputs

      def initialize(name:, outputs:)
        @name = name
        @outputs = outputs
      end

      def init_inputs(_inputs); end

      def receive(pulse, _input)
        @outputs.map { |n| [@name, pulse, n] }
      end
    end

    def process_input(str)
      schema = str.split("\n").to_h do |line|
        mod, outs = line.split(" -> ")
        klass =
          case mod[0]
          when "&"
            Conjunction
          when "%"
            FlipFlop
          else
            Broadcaster
          end
        [mod == "broadcaster" ? mod : mod[1..], klass.new(name: mod, outputs: outs.split(", "))]
      end
      schema.keys.each do |c|
        inputs = schema.values.select { |mod| mod.outputs.include?(c) }.map(&:name)
        schema[c].init_inputs(inputs)
      end
      schema
    end

    def problem1(input)
      counts = [0, 0]
      1000.times do
        queue = [["button", :low, "broadcaster"]]
        until queue.empty?
          op = queue.shift
          counts[op[1] == :low ? 0 : 1] += 1
          queue.push(*input[op[2]].receive(op[1], op[0])) if input[op[2]]
        end
      end
      counts.inject(&:*)
    end

    # I tried two methods for solving this puzzle and they both give me the phase result,
    # but AoC seems to accept the period (which is 1000 more than the phase). I think it's
    # a mistake.
    def problem2(input)
      mods_of_interest = %w[rd bt fv pr]
      count_till_low = mods_of_interest.to_h { |mod| [mod, []] }
      count = 0
      until count_till_low.values.all? { |v| v.size > 2 }
        queue = [["button", :low, "broadcaster"]]
        count += 1
        until queue.empty?
          op = queue.shift
          if mods_of_interest.include?(op[2]) && op[1] == :low
            count_till_low[op[2]].push(count)
          end

          queue.push(*input[op[2]].receive(op[1], op[0])) if input[op[2]]
        end
      end
      p count_till_low
      ref_points = count_till_low.values.map { |ph, pt| [ph, pt - ph]}
      p ref_points
      # phase = -count_till_low.first % period
      # [phase, period]
      crt = ref_points.inject do |(rem0, period0), (rem1, period1)|
        x = rem0
        until x % period1 == rem1
          x += period0
        end
        [x, period0 * period1]
      end.first
      p crt
      phase, period = ref_points.map {|ph, pr| [-ph%pr, pr] }.inject do |(phase0, period0), (phase1, period1)|
        gcd, s, t = extended_gcd(period0, period1)
        p [gcd, s, t]
        phase_diff = phase0 - phase1
        pd_mult, pd_rem = phase_diff.divmod(gcd)
        raise "No intersection" unless pd_rem.zero?

        combined_period = period0 / gcd * period1
        combined_phase = (phase0 - s * pd_mult * period0) % combined_period
        p [combined_phase, combined_period]
      end
      -phase % period
    end

    private

    # https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm
    def extended_gcd(a, b)
      old_r = a
      r = b
      old_s = t = 1
      old_t = s = 0
      while r > 0
        quotient, rem = old_r.divmod(r)
        old_r = r
        r = rem
        old_s, s = s, old_s - quotient * s
        old_t, t = t, old_t - quotient * t
      end
      return [old_r, old_s, old_t]
    end
  end
end
