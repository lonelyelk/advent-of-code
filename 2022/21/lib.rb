# frozen_string_literal: true

# https://adventofcode.com/2022/day/21
module Year2022
  module Day21
    def process_input(str)
      str.split("\n").reject(&:empty?).map { |l| l.sub(":", " =").gsub(/(\w{4})/, 'h[:\1]') }
    end

    def problem1(input)
      h = {}
      while !input.empty?
        input = input.each_with_object([]) do |l, left|
          eval(l)
        rescue TypeError, NoMethodError
          left.push(l)
        end
      end
      h[:root]
    end

    def problem2(input)
      h = {}
      lookup = "h[:humn]"
      input = input.reject { |l| l[...lookup.size] == lookup }
      output = []
      loop do
        re = /^(\S+) = (\S+) (\S) (\S+)$/
        i = input.index { |l| /=.+#{lookup.sub("[", "\\[").sub("]", "\\]")}/.match?(l) }
        md = re.match(input.slice!(i))
        l = "#{lookup} = "
        if md[2] == lookup
          if md[1] == "h[:root]"
            l += md[4]
          else
            case md[3]
            when ?+
              l += "#{md[1]} - #{md[4]}"
            when ?-
              l += "#{md[1]} + #{md[4]}"
            when ?/
              l += "#{md[1]} * #{md[4]}"
            when ?*
              l += "#{md[1]} / #{md[4]}"
            end
          end
        else
          if md[1] == "h[:root]"
            l += md[2]
          else
            case md[3]
            when ?+
              l += "#{md[1]} - #{md[2]}"
            when ?-
              l += "#{md[2]} - #{md[1]}"
            when ?/
              l += "#{md[2]} / #{md[1]}"
            when ?*
              l += "#{md[1]} / #{md[2]}"
            end
          end
        end
        output.push(l)
        lookup = md[1]
        break if lookup == "h[:root]"
      end
      input += output
      while !input.empty?
        input = input.each_with_object([]) do |l, left|
          left.push(l) if eval(l).nil?
        rescue TypeError, NoMethodError
          left.push(l)
        end
      end
      h[:humn]
    end
  end
end
