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
      @worry_down = 3
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

    # rubocop:disable Lint/UnusedBlockArgument, Security/Eval, Metrics/AbcSize
    def process_monkey1(code)
      md = code.match(PARSER_RE)
      {
        items: md[1].split(", ").map(&:to_i),
        inspected: 0,
        inspect: ->(old) { eval(md[2]) / 3 },
        throw: ->(item) { (item % md[3].to_i).zero? ? md[4].to_i : md[5].to_i },
      }
    end

    def process_monkey2(code)
      md = code.match(PARSER_RE)
      {
        items: md[1].split(", ").map(&:to_i),
        inspected: 0,
        divisible: md[3].to_i,
        inspect: ->(old) { eval(md[2]) % @worry_down },
        throw: ->(item) { (item % md[3].to_i).zero? ? md[4].to_i : md[5].to_i },
      }
    end
    # rubocop:enable Lint/UnusedBlockArgument, Security/Eval, Metrics/AbcSize

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
