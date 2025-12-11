# frozen_string_literal: true

require_relative "../../../2025/11/lib"

RSpec.describe Year2025::Day11 do
  include described_class

  let(:input) do
    %(aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
)
  end
  let(:processed_input) do
    {
      "aaa" => %w[you hhh],
      "you" => %w[bbb ccc],
      "bbb" => %w[ddd eee],
      "ccc" => %w[ddd eee fff],
      "ddd" => %w[ggg],
      "eee" => %w[out],
      "fff" => %w[out],
      "ggg" => %w[out],
      "hhh" => %w[ccc fff iii],
      "iii" => %w[out],
    }
  end
  let(:input2) do
    %(svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
)
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 5 for test input" do
      expect(problem1(processed_input)).to eq(5)
    end
  end

  describe "problem2" do
    it "returns 2 for test input" do
      expect(problem2(process_input(input2))).to eq(2)
    end
  end
end
