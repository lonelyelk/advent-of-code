# frozen_string_literal: true

require_relative "../../../2021/24/lib"

RSpec.describe Day24 do
  include described_class

  let(:input) do
    %(inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2
)
  end
  let(:processed_input) do
    [
      %w[inp w],
      %w[add z w],
      %w[mod z 2],
      %w[div w 2],
      %w[add y w],
      %w[mod y 2],
      %w[div w 2],
      %w[add x w],
      %w[mod x 2],
      %w[div w 2],
      %w[mod w 2],
    ]
  end
  let(:real_input) do
    File.read(File.join(__dir__, "..", "..", "..", "2021", "24", "input.txt"))
  end

  describe "process_input" do
    it "consumes multiline string and returns processed input" do
      expect(process_input(input)).to eq(processed_input)
    end
  end

  describe "run" do
    it "runs ALU program" do
      expect(run(processed_input, inp: [10])).to eq("w" => 1, "x" => 0, "y" => 1, "z" => 0)
    end
  end

  describe "serial_check" do
    10.times do
      it "does the same thing as running of the input program" do
        inp = Array.new(14) { rand(1..9) }
        expect(serial_check(inp.join.to_i)).to eq(run(process_input(real_input), inp: inp)["z"])
      end
    end
  end

  xdescribe "problem1" do
    it "returns 91_297_395_919_993 for real input" do
      expect(problem1(process_input(real_input))).to eq(91_297_395_919_993)
    end
  end

  xdescribe "problem2" do
    it "returns 71_131_151_917_891 for real input" do
      expect(problem2(process_input(real_input))).to eq(71_131_151_917_891)
    end
  end
end
