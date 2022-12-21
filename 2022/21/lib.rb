# frozen_string_literal: true

# https://adventofcode.com/2022/day/21
module Year2022
  module Day21
    def process_input(str)
      str.split("\n").reject(&:empty?).map { |l| l.sub(":", " =").gsub(/(\w{4})/, 'h[:\1]') }
    end

    def problem1(input)
      h = eval_to_h(input)
      h[:root]
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def problem2(input)
      lookup = "h[:humn]"
      input = input.reject { |l| l[...lookup.size] == lookup }
      output = []
      loop do
        re = /^(\S+) = (\S+) (\S) (\S+)$/
        i = input.index { |l| l.match?(/=.+#{lookup[3, 4]}/) }
        md = re.match(input.slice!(i))
        l = "#{lookup} = " +
            if md[2] == lookup
              md[1] == "h[:root]" ? md[4] : extract_first(md[1], md[3], md[4])
            elsif md[1] == "h[:root]"
              md[2]
            else
              extract_second(md[1], md[3], md[2])
            end
        output.push(l)
        lookup = md[1]
        break if lookup == "h[:root]"
      end
      h = eval_to_h(input + output)
      h[:humn]
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    def eval_to_h(input)
      h = {}
      until input.empty?
        input = input.each_with_object([]) do |l, left|
          left.push(l) if eval(l).nil?
        rescue TypeError, NoMethodError
          left.push(l)
        end
      end
      h
    end

    def extract_first(left, operation, second)
      case operation
      when ?+
        "#{left} - #{second}"
      when ?-
        "#{left} + #{second}"
      when ?/
        "#{left} * #{second}"
      when ?*
        "#{left} / #{second}"
      end
    end

    def extract_second(left, opearion, first)
      case opearion
      when ?+
        "#{left} - #{first}"
      when ?-
        "#{first} - #{left}"
      when ?/
        "#{first} / #{left}"
      when ?*
        "#{left} / #{first}"
      end
    end
  end
end
