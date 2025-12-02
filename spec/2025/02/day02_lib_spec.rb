# frozen_string_literal: true

require_relative "../../../2025/02/lib"

RSpec.describe Year2025::Day02 do
  include described_class

  let(:input) do
    %(11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124
)
  end
  let(:processed_input) do
    [
      %w[11 22],
      %w[95 115],
      %w[998 1012],
      %w[1188511880 1188511890],
      %w[222220 222224],
      %w[1698522 1698528],
      %w[446443 446449],
      %w[38593856 38593862],
      %w[565653 565659],
      %w[824824821 824824827],
      %w[2121212118 2121212124],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns nil for test input" do
      expect(problem1(processed_input)).to eq(1_227_775_554)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(4_174_379_265)
    end
  end
end
