# frozen_string_literal: true

# https://adventofcode.com/2022/day/11
module Year2022
  module Day11
    # rubocop:disable Style/RegexpLiteral
    PARSER_RE = %r{Monkey \d+:
  Starting items: ([0-9, ]+)
  Operation: new = (.+)
  Test: divisible by (\d+)
    If true: throw to monkey (\d+)
    If false: throw to monkey (\d+)}
    # rubocop:enable Style/RegexpLiteral

    def process_input(str)
      str.split("\n\n").reject(&:empty?).map(&:chomp)
    end

    def problem1(input)
      monkeys = input.map { |code| process_monkey1(code) }
      20.times { monkey_round(monkeys) }
      monkeys.map { |m| m[:inspected] }.sort[-2..].inject(:*)
    end

    def problem2(input)
      monkeys = input.map { |code| process_monkey2(code) }
      @worry_down = monkeys.map { |m| m[:divisible] }.inject(&:*)
      10_000.times { monkey_round(monkeys) }
      monkeys.map { |m| m[:inspected] }.sort[-2..].inject(:*)
    end

    private

    def parse(code)
      md = code.match(PARSER_RE)
      {
        items: md[1].split(", ").map(&:to_i),
        inspect_code: md[2],
        divisible: md[3].to_i,
        monkey_true: md[4].to_i,
        monkey_false: md[5].to_i,
      }
    end

    # rubocop:disable Lint/UnusedBlockArgument
    def process_monkey1(code)
      parsed = parse(code)
      {
        items: parsed[:items],
        inspected: 0,
        inspect: ->(old) { eval(parsed[:inspect_code]) / 3 },
        throw: ->(item) { (item % parsed[:divisible]).zero? ? parsed[:monkey_true] : parsed[:monkey_false] },
      }
    end

    def process_monkey2(code)
      parsed = parse(code)
      {
        items: parsed[:items],
        inspected: 0,
        divisible: parsed[:divisible],
        inspect: ->(old) { eval(parsed[:inspect_code]) % @worry_down },
        throw: ->(item) { (item % parsed[:divisible]).zero? ? parsed[:monkey_true] : parsed[:monkey_false] },
      }
    end
    # rubocop:enable Lint/UnusedBlockArgument, Security/Eval

    def monkey_round(monkeys)
      monkeys.each do |monkey|
        monkey[:inspected] += monkey[:items].size
        monkey[:items].each do |item|
          new_item = monkey[:inspect][item]
          monkeys[monkey[:throw][new_item]][:items].push(new_item)
        end
        monkey[:items] = []
      end
    end
  end
end
