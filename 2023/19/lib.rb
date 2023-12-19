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
      { workflows: process_workflows(workflows), ratings: process_ratings(ratings) }
    end

    def problem1(input)
      input[:ratings].sum do |r|
        op = "in"
        op = next_step(input[:workflows], op, r) until %w[A R].include?(op)
        op == "A" ? r.sum : 0
      end
    end

    # rubocop:disable Metrics/AbcSize
    def problem2(input)
      flows = [["in", [], []]]
      flows = next_workflow_steps(flows, input) until flows.all? { |f| %w[A R].include?(f.first) }
      flows = invert_negative_rules(flows.select { |f| f.first == "A" })
      apply_to_default_ranges(flows).sum do |ranges|
        ranges.values.map { |min, max| max - min + 1 }.inject(&:*)
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def process_ratings(ratings)
      ratings.map do |l|
        md = l.match(/x=(\d+),m=(\d+),a=(\d+),s=(\d+)/)
        Part.new(x: md[1].to_i, m: md[2].to_i, a: md[3].to_i, s: md[4].to_i)
      end
    end

    def process_workflows(workflows)
      workflows.each_with_object({}) do |l, wf|
        md = l.match(/(\w+)\{(.+)\}/)
        wf[md[1]] = md[2].split(",").map { |op| op.split(":") }
      end
    end

    def next_step(workflows, operation, rating)
      workflows[operation].each do |wf|
        return wf.first if wf.size == 1
        return wf[1] if rating.b.eval(wf[0])
      end
    end

    def next_workflow_steps(workflows, input)
      workflows.each_with_object([]) do |workflow, nf|
        if %w[A R].include?(workflow.first)
          nf.push(workflow)
        else
          nf.push(*all_next_steps(workflow, input))
        end
      end
    end

    def all_next_steps(workflow, input)
      op, yes, no = workflow
      input[:workflows][op].map do |wf|
        if wf.size == 1
          [wf.last, yes, no]
        else
          res = [wf.last, [*yes, wf.first], no]
          no = [*no, wf.first]
          res
        end
      end
    end

    def invert_negative_rules(workflows)
      workflows.map do |_, yes, no|
        y = no.map do |s|
          md = s.match(/(\w)([<>])(\d+)/)
          md[2] == "<" ? "#{md[1]}>#{md[3].to_i - 1}" : "#{md[1]}<#{md[3].to_i + 1}"
        end
        [*yes, *y]
      end
    end

    # rubocop:disable Metrics/AbcSize
    def apply_to_default_ranges(workflows)
      workflows.map do |rules|
        rules.each_with_object(default_ranges) do |rule, ranges|
          md = rule.match(/(\w)([<>])(\d+)/)
          ranges[md[1]][1] = [md[3].to_i - 1, ranges[md[1]][1]].min if md[2] == "<"
          ranges[md[1]][0] = [md[3].to_i + 1, ranges[md[1]][0]].max if md[2] == ">"
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    def default_ranges
      { "x" => [1, 4000], "m" => [1, 4000], "a" => [1, 4000], "s" => [1, 4000] }
    end
  end
end
