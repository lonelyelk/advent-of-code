require_relative "../../../2021/01/lib"

RSpec.describe "day 1" do
  let(:input) do
    %Q(
199
200
208
210
200
207
240
269
260
263
)
  end

  describe "process_input" do
    it "consumes multiline string and returns an array of ints" do
      expect(process_input(input)).to eq([
        199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263,
      ])
    end
  end
end
