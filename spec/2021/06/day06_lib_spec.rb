# frozen_string_literal: true

require_relative "../../../2021/06/lib"

RSpec.describe Day06 do
  include described_class

  let(:input) do
    %(
3,4,3,1,2
)
  end
  let(:processed_input) do
    [3, 4, 3, 1, 2]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 5934 for test input" do
      expect(problem1(processed_input)).to eq(5934)
    end
  end

  describe "problem2" do
    it "returns 26_984_457_539 for test input" do
      expect(problem2(processed_input)).to eq(26_984_457_539)
    end
  end
end
