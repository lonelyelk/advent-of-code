# frozen_string_literal: true

require_relative "../../../2024/23/lib"

RSpec.describe Year2024::Day23 do
  include described_class

  let(:input) do
    %(kh-tc
qp-kh
de-cg
ka-co
yn-aq
qp-ub
cg-tb
vc-aq
tb-ka
wh-tc
yn-cg
kh-ub
ta-co
de-co
tc-td
tb-wq
wh-td
ta-ka
td-qp
aq-cg
wq-ub
ub-vc
de-ta
wq-aq
wq-vc
wh-yn
ka-de
kh-ta
co-tc
wh-qp
tb-vc
td-yn
)
  end

  describe "problem1" do
    it "returns 7 for test input" do
      expect(problem1(process_input(input))).to eq(7)
    end
  end

  describe "problem2" do
    it "returns 'co,de,ka,ta' for test input" do
      expect(problem2(process_input(input))).to eq("co,de,ka,ta")
    end
  end
end
