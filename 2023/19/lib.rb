# frozen_string_literal: true

# https://adventofcode.com/2023/day/19
module Year2023
  module Day19
    Part = Struct.new(:x, :m, :a, :s) do |_c|
      def b
        binding
      end
    end
    def process_input(str)
      workflows, ratings = str.split("\n\n").map { |section| section.split("\n") }
      ratings = ratings.map do |l|
        md = l.match(/x=(\d+),m=(\d+),a=(\d+),s=(\d+)/)
        Part.new(x: md[1].to_i, m: md[2].to_i, a: md[3].to_i, s: md[4].to_i)
      end
      workflows = workflows.each_with_object({}) do |l, wf|
        md = l.match(/(\w+)\{(.+)\}/)
        wf[md[1]] = md[2].split(",").map { |op| op.split(":") }
      end
      { workflows:, ratings: }
    end

    def problem1(input)
      input[:ratings].sum do |r|
        op = "in"
        op = process_step(input[:workflows], op, r) until %w[A R].include?(op)
        op == "A" ? r.sum : 0
      end
    end

    def problem2(input)
      flows = [["in", [], []]]
      until flows.all? { |f| %w[A R].include?(f.first) }
        flows = flows.each_with_object([]) do |(op, yes, no), nf|
          if %w[A R].include?(op)
            nf.push([op, yes, no])
          else
            input[:workflows][op].each do |wf|
              if wf.size == 1
                nf.push([wf.last, yes, no])
              else
                nf.push([wf.last, [*yes, wf.first], no])
                no = [*no, wf.first]
              end
            end
          end
        end
      end
      flows = flows.select { |f| f.first == "A" }.map do |_, yes, no|
        y = no.map do |s|
          md = s.match(/(\w)([<>])(\d+)/)
          case md[2]
          when "<"
            "#{md[1]}>#{md[3].to_i - 1}"
          when ">"
            "#{md[1]}<#{md[3].to_i + 1}"
          end
        end
        [*yes, *y]
      end
      flows = flows.map do |rules|
        rules.each_with_object(default_ranges) do |rule, ranges|
          md = rule.match(/(\w)([<>])(\d+)/)
          case md[2]
          when "<"
            ranges[md[1]][1] = [md[3].to_i - 1, ranges[md[1]][1]].min
          when ">"
            ranges[md[1]][0] = [md[3].to_i + 1, ranges[md[1]][0]].max
          end
        end
      end
      flows.sum do |ranges|
        ranges.values.map { |min, max| max - min + 1 }.inject(&:*)
      end
    end

    private

    def process_step(workflows, operation, rating)
      workflows[operation].each do |wf|
        return wf.first if wf.size == 1
        return wf[1] if rating.b.eval(wf[0])
      end
    end

    def default_ranges
      { "x" => [1, 4000], "m" => [1, 4000], "a" => [1, 4000], "s" => [1, 4000] }
    end
  end
end
