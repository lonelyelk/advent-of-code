# frozen_string_literal: true

require_relative "../../../2021/18/lib"

EXPLOSION = {
  "[[[[[9,8],1],2],3],4]" => "[[[[0,9],2],3],4]",
  "[7,[6,[5,[4,[3,2]]]]]" => "[7,[6,[5,[7,0]]]]",
  "[[6,[5,[4,[3,2]]]],1]" => "[[6,[5,[7,0]]],3]",
  "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]" => "[[3,[2,[8,0]]],[9,[5,[7,0]]]]",
}.freeze
MAGNITUDE = {
  "[[1,2],[[3,4],5]]" => 143,
  "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]" => 1384,
  "[[[[1,1],[2,2]],[3,3]],[4,4]]" => 445,
  "[[[[3,0],[5,3]],[4,4]],[5,5]]" => 791,
  "[[[[5,0],[7,4]],[5,5]],[6,6]]" => 1137,
  "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]" => 3488,
}

RSpec.describe Day18 do
  include described_class

  let(:input) do
    %([[1,9],[8,5]]
)
  end
  let(:processed_input) do
    [
      [
        { path: [:l, :l], value: 1 },
        { path: [:l, :r], value: 9 },
        { path: [:r, :l], value: 8 },
        { path: [:r, :r], value: 5 }
      ]
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "number_to_s" do
    EXPLOSION.each do |input, result|
      it "encodes and decodes #{input}" do
        expect(number_to_s(process_line(input))).to eq(input)
      end

      it "encodes and decodes #{result}" do
        expect(number_to_s(process_line(result))).to eq(result)
      end
    end
  end

  describe "explode" do
    EXPLOSION.each do |input, result|
      it "explodes #{input} to #{result}" do
        expect(explode(process_line(input))).to eq(process_line(result))
      end
    end
  end

  describe "add" do
    it "adds two numbers" do
      expect(add(process_line("[1,2]"), process_line("[[3,4],5]"))).to eq(process_line("[[1,2],[[3,4],5]]"))
    end
  end

  describe "split" do
    it "splits a number once" do
      expect(number_to_s(split(explode(process_line("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]"))))).to eq("[[[[0,7],4],[[7,8],[0,13]]],[1,1]]")
    end

    it "splits the second number second time" do
      expect(split(split(explode(process_line("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]"))))).to eq(process_line("[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]"))
    end
  end

  describe "add_list" do
    let(:input) do
      %([[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
[7,[5,[[3,8],[1,4]]]]
[[2,[2,2]],[8,[8,1]]]
[2,9]
[1,[[[9,3],9],[[9,0],[0,7]]]]
[[[5,[7,4]],7],1]
[[[[4,2],2],6],[8,7]]
)
    end

    let(:sum) do
      "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"
    end

    it "adds list of numbers and explodes and splits when needed" do
      expect(add_list(process_input(input))).to eq(process_line(sum))
    end
  end

  describe "magnitude" do
    MAGNITUDE.each do |input, result|
      it "calculates magnitude of #{input} as equal to #{result}" do
        expect(magnitude(process_line(input))).to eq(result)
      end
    end
  end

  describe "problem1" do
    let(:input) do
      %([[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
)
    end

    it "returns 4140 for test input" do
      expect(problem1(process_input(input))).to eq(4140)
    end
  end

  describe "problem2" do
    let(:input) do
      %([[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
)
    end

    it "returns 3993 for test input" do
      expect(problem2(process_input(input))).to eq(3993)
    end
  end
end
