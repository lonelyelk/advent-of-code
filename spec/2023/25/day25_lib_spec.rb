# frozen_string_literal: true

require_relative "../../../2023/25/lib"

RSpec.describe Year2023::Day25 do
  include described_class

  let(:input) do
    %(jqt: rhn xhk nvd
rsh: frs pzl lsr
xhk: hfx
cmg: qnr nvd lhk bvb
rhn: xhk bvb hfx
bvb: xhk hfx
pzl: lsr hfx nvd
qnr: nvd
ntq: jqt hfx bvb xhk
nvd: lhk
lsr: lhk
rzs: qnr cmg lsr rsh
frs: qnr lhk lsr
)
  end
  let(:processed_input) do
    {
      "bvb" => %w[cmg rhn xhk hfx ntq].to_h { |n| [n, true] },
      "cmg" => %w[qnr nvd lhk bvb rzs].to_h { |n| [n, true] },
      "frs" => %w[rsh qnr lhk lsr].to_h { |n| [n, true] },
      "hfx" => %w[xhk rhn bvb pzl ntq].to_h { |n| [n, true] },
      "jqt" => %w[rhn xhk nvd ntq].to_h { |n| [n, true] },
      "lhk" => %w[cmg nvd lsr frs].to_h { |n| [n, true] },
      "lsr" => %w[rsh pzl lhk rzs frs].to_h { |n| [n, true] },
      "ntq" => %w[jqt hfx bvb xhk].to_h { |n| [n, true] },
      "nvd" => %w[jqt cmg pzl qnr lhk].to_h { |n| [n, true] },
      "pzl" => %w[rsh lsr hfx nvd].to_h { |n| [n, true] },
      "qnr" => %w[cmg nvd rzs frs].to_h { |n| [n, true] },
      "rhn" => %w[jqt xhk bvb hfx].to_h { |n| [n, true] },
      "rsh" => %w[frs pzl lsr rzs].to_h { |n| [n, true] },
      "rzs" => %w[qnr cmg lsr rsh].to_h { |n| [n, true] },
      "xhk" => %w[jqt hfx rhn bvb ntq].to_h { |n| [n, true] },
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 54 for test input" do
      expect(problem1(processed_input)).to eq(54)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to be_nil
    end
  end
end
