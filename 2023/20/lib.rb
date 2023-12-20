# frozen_string_literal: true

# https://adventofcode.com/2023/day/20
module Year2023
  module Day20
    class Mod
      attr_reader :name, :inputs, :outputs

      def initialize(name:, outputs:)
        @name = name[1..]
        @outputs = outputs
      end

      def init_inputs(_inputs); end

      def reset; end
    end

    class FlipFlop < Mod
      def initialize(name:, outputs:)
        @state = :off
        super
      end

      def reset
        @state = :off
      end

      def receive(pulse, _input)
        return [] if pulse == :high

        @state = @state == :off ? :on : :off
        @outputs.map { |n| [@name, @state == :on ? :high : :low, n] }
      end
    end

    class Conjunction < Mod
      def init_inputs(inputs)
        @states = inputs.to_h { |n| [n, :low] }
      end

      def reset
        @states = @states.keys.to_h { |n| [n, :low] }
      end

      def receive(pulse, input)
        @states[input] = pulse
        out_pulse = @states.values.all?(:high) ? :low : :high
        @outputs.map { |n| [@name, out_pulse, n] }
      end
    end

    class Broadcaster < Mod
      def initialize(name:, outputs:)
        super
        @name = name
      end

      def receive(pulse, _input)
        @outputs.map { |n| [@name, pulse, n] }
      end
    end

    MODS_OF_INTEREST = %w[rd bt fv pr].freeze # according to the diagram.md

    def process_input(str)
      schema = str.split("\n").to_h do |line|
        mod, outs = line.split(" -> ")
        [mod.sub(/\W/, ""), mod_class(mod).new(name: mod, outputs: outs.split(", "))]
      end
      init_inputs(schema)
    end

    def problem1(input)
      reset(input) # almost forgot this
      counts = [0, 0]
      1000.times do
        run_button(input) do |_, pulse, _|
          counts[pulse == :low ? 0 : 1] += 1
        end
      end
      counts.inject(&:*)
    end

    def problem2(input)
      reset(input) # almost forgot this
      count, count_till_low = 0, MODS_OF_INTEREST.to_h { |mod| [mod, 0] }
      while count_till_low.values.any?(&:zero?)
        count += 1
        run_button(input) do |_, pulse, out|
          count_till_low[out] = count if MODS_OF_INTEREST.include?(out) && pulse == :low
        end
      end
      count_till_low.values.inject(&:lcm)
    end

    private

    def mod_class(mod)
      case mod[0]
      when "&"
        Conjunction
      when "%"
        FlipFlop
      else
        Broadcaster
      end
    end

    def init_inputs(schema)
      schema.each_key do |c|
        inputs = schema.values.select { |mod| mod.outputs.include?(c) }.map(&:name)
        schema[c].init_inputs(inputs)
      end
      schema
    end

    def reset(schema)
      schema.each_value(&:reset)
    end

    def run_button(schema)
      queue = [["button", :low, "broadcaster"]]
      until queue.empty?
        op = queue.shift
        yield(op)
        queue.push(*schema[op[2]].receive(op[1], op[0])) if schema[op[2]]
      end
    end
  end
end
