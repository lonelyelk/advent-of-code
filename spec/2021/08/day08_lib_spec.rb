# frozen_string_literal: true

require_relative "../../../2021/08/lib"

RSpec.describe Day08 do
  include described_class

  let(:input) do
    %(
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
)
  end
  let(:processed_input) do
    [
      [
        %w[be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb],
        %w[fdgacbe cefdb cefbgd gcbe],
      ],
      [
        %w[edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec],
        %w[fcgedb cgb dgebacf gc],
      ],
      [
        %w[fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef],
        %w[cg cg fdcagb cbg],
      ],
      [
        %w[fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega],
        %w[efabcd cedba gadfec cb],
      ],
      [
        %w[aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga],
        %w[gecf egdcabf bgf bfgea],
      ],
      [
        %w[fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf],
        %w[gebdcfa ecba ca fadegcb],
      ],
      [
        %w[dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf],
        %w[cefg dcbef fcge gbcadfe],
      ],
      [
        %w[bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd],
        %w[ed bcgafe cdgba cbgef],
      ],
      [
        %w[egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg],
        %w[gbdfcae bgc cg cgb],
      ],
      [
        %w[gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc],
        %w[fgae cfgab fg bagce],
      ],
    ]
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 26 for test input" do
      expect(problem1(processed_input)).to eq(26)
    end
  end

  describe "problem2" do
    it "returns 61_229 for test input" do
      expect(problem2(processed_input)).to eq(61_229)
    end
  end
end
