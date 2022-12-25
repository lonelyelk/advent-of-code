# frozen_string_literal: true

require_relative "../../../2022/25/lib"

RSpec.describe Year2022::Day25 do
  include described_class

  let(:input) do
    %(1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
)
  end
  let(:processed_input) do
    %w[
      1=-0-2
      12111
      2=0=
      21
      2=01
      111
      20012
      112
      1=-1=
      1-12
      12
      1=
      122
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 4890 for test input" do
      expect(problem1(processed_input)).to eq(4890)
    end

    it "returns 4890 for test input" do
      expect(problem1(%w[2=-1=0])).to eq(4890)
    end
  end

  describe "problem2" do
    it "returns '2=-1=0' for test output of problem1" do
      expect(problem2(4890)).to eq("2=-1=0")
    end

    it "returns '1=-1=' for test output of problem1" do
      expect(problem2(353)).to eq("1=-1=")
    end
  end
end
