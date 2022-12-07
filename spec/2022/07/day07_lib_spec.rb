# frozen_string_literal: true

require_relative "../../../2022/07/lib"

RSpec.describe Year2022::Day07 do
  include described_class

  let(:input) do
    %($ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
)
  end
  let(:processed_input) do
    {
      'a' => {
        'e' => { 'i' => 584 },
        'f' => 29116,
        'g' => 2557,
        'h.lst' => 62596,
      },
      'b.txt' => 14848514,
      'c.dat' => 8504156,
      'd' => {
        'j' => 4060174,
        'd.log' => 8033020,
        'd.ext' => 5626152,
        'k' => 7214296,
      }
    }
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "problem1" do
    it "returns 95437 for test input" do
      expect(problem1(processed_input)).to eq(95437)
    end
  end

  describe "problem2" do
    it "returns nil for test input" do
      expect(problem2(processed_input)).to eq(nil)
    end
  end
end
