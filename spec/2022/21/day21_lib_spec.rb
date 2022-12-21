# frozen_string_literal: true

require_relative "../../../2022/21/lib"

RSpec.describe Year2022::Day21 do
  include described_class

  let(:input) do
    %(root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32
)
  end
  let(:processed_input) do
    [
      "h[:root] = h[:pppw] + h[:sjmn]",
      "h[:dbpl] = 5",
      "h[:cczh] = h[:sllz] + h[:lgvd]",
      "h[:zczc] = 2",
      "h[:ptdq] = h[:humn] - h[:dvpt]",
      "h[:dvpt] = 3",
      "h[:lfqf] = 4",
      "h[:humn] = 5",
      "h[:ljgn] = 2",
      "h[:sjmn] = h[:drzm] * h[:dbpl]",
      "h[:sllz] = 4",
      "h[:pppw] = h[:cczh] / h[:lfqf]",
      "h[:lgvd] = h[:ljgn] * h[:ptdq]",
      "h[:drzm] = h[:hmdt] - h[:zczc]",
      "h[:hmdt] = 32",
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 152 for test input" do
      expect(problem1(processed_input)).to eq(152)
    end
  end

  describe "problem2" do
    it "returns 301 for test input" do
      expect(problem2(processed_input)).to eq(301)
    end
  end
end
