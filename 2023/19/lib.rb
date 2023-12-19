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
    end

    def process_step(workflows, operation, rating)
      workflows[operation].each do |wf|
        return wf.first if wf.size == 1
        return wf[1] if rating.b.eval(wf[0])
      end
    end
  end
end
