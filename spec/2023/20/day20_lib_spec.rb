# frozen_string_literal: true

require_relative "../../../2023/20/lib"

RSpec.describe Year2023::Day20 do
  include described_class

  let(:input) do
    %(broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
)
  end

  describe "problem1" do
    it "returns 32_000_000 for test input" do
      expect(problem1(process_input(input))).to eq(32_000_000)
    end
  end
end
