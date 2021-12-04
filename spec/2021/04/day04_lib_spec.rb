# frozen_string_literal: true

require_relative "../../../2021/04/lib"

RSpec.describe Day04 do
  include described_class

  let(:input) do
    %(
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
)
  end
  let(:processed_input) do
    [
      [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26, 1],
      board1 + board1.transpose,
      board2 + board2.transpose,
      board3 + board3.transpose,
    ]
  end
  let(:board1) do
    [
      [22, 13, 17, 11, 0],
      [8,  2, 23,  4, 24],
      [21, 9, 14, 16, 7],
      [6, 10, 3, 18, 5],
      [1, 12, 20, 15, 19],
    ]
  end
  let(:board2) do
    [
      [3, 15,  0, 2, 22],
      [9, 18, 13, 17, 5],
      [19, 8, 7, 25, 23],
      [20, 11, 10, 24,  4],
      [14, 21, 16, 12,  6],
    ]
  end
  let(:board3) do
    [
      [14, 21, 17, 24,  4],
      [10, 16, 15, 9, 19],
      [18, 8, 23, 26, 20],
      [22, 11, 13, 6, 5],
      [2,  0, 12, 3, 7],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 4512 for test input" do
      expect(problem1(processed_input)).to eq(4512)
    end
  end

  describe "problem2" do
    it "returns 31424 for test input" do
      expect(problem2(processed_input)).to eq(1924)
    end
  end
end
