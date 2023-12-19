# frozen_string_literal: true

require_relative "../../../2023/19/lib"

RSpec.describe Year2023::Day19 do
  include described_class

  let(:input) do
    %(px{a<2006:qkq,m>2090:A,rfg}
pv{a>1716:R,A}
lnx{m>1548:A,A}
rfg{s<537:gd,x>2440:R,A}
qs{s>3448:A,lnx}
qkq{x<1416:A,crn}
crn{x>2662:A,R}
in{s<1351:px,qqz}
qqz{s>2770:qs,m<1801:hdj,R}
gd{a>3333:R,R}
hdj{m>838:A,pv}

{x=787,m=2655,a=1222,s=2876}
{x=1679,m=44,a=2067,s=496}
{x=2036,m=264,a=79,s=2244}
{x=2461,m=1339,a=466,s=291}
{x=2127,m=1623,a=2188,s=1013}
)
  end
  let(:processed_input) do
    nil
  end

  xdescribe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 19114 for test input" do
      expect(problem1(process_input(input))).to eq(19114)
    end
  end

  describe "problem2" do
    it "returns 167409079868000 for test input" do
      expect(problem2(process_input(input))).to eq(167409079868000)
    end
  end
end
