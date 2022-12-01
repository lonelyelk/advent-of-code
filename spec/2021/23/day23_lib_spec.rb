# frozen_string_literal: true

require_relative "../../../2021/23/lib"

# rubocop:disable Style/SymbolArray
RSpec.describe Day23 do
  include described_class

  let(:input) do
    %(#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########
)
  end
  let(:processed_input) do
    [
      Array.new(11),
      [:B, :C, :B, :D],
      [:A, :D, :C, :A],
      0,
    ]
  end

  describe "possible_moves" do
    context "with move out moves" do
      let(:state1) do
        [
          [nil, :B, nil, :C, nil, :D, nil, :A, nil, nil, nil],
          Array.new(4),
          [:A, :D, :C, :B],
          0,
        ]
      end

      it "returns possible moves for initial state" do
        expect(possible_moves(processed_input).size).to eq(28)
      end

      it "returns possible moves with costs" do
        expect(possible_moves(processed_input).map(&:size)).to all(eq(4))
      end

      it "places one amphipod in a hall possible moves with costs" do
        expect(possible_moves(processed_input).map { |st| st[0].count { |pos| !pos.nil? } }).to all(eq(1))
      end

      it "returns possible moves for almost all out state" do
        expect(possible_moves(state1).size).to eq(2)
      end

      it "calculates costs of possible moves for almost all out state correctly" do
        expect(possible_moves(state1).map { |st| st[3] }).to match_array([30, 40])
      end
    end

    context "with move in moves" do
      let(:state1) do
        [
          [nil, :A, nil, :B, nil, :D, nil, nil, nil, :C, nil],
          Array.new(4),
          [:A, :D, :C, :B],
          0,
        ]
      end
      let(:state2) do
        [
          [nil, nil, nil, :B, nil, :D, nil, :C, nil, :C, nil],
          [:A, nil, nil, nil],
          [:A, :D, nil, :B],
          0,
        ]
      end

      it "detects two amphipods that can return" do
        expect(possible_moves(state1).size).to eq(3)
      end

      it "calculates cost of return" do
        expect(possible_moves(state1).map { |st| st[3] }).to match_array([30, 2, 400])
      end

      it "detects one amphipod that can return" do
        expect(possible_moves(state2).size).to eq(1)
      end

      it "calculates the cost of return for single amphipod" do
        expect(possible_moves(state2).map { |st| st[3] }).to match_array([300])
      end
    end
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 12_521 for test input" do
      expect(problem1(processed_input)).to eq(12_521)
    end
  end

  describe "problem2" do
    it "returns 44_169 for test input" do
      expect(problem2(processed_input)).to eq(44_169)
    end
  end
end
# rubocop:enable Style/SymbolArray
