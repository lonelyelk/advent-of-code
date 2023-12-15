# frozen_string_literal: true

require_relative "lib"
include Year2023::Day15

input_path = File.join(__dir__, "input.txt")
input = process_input(File.read(input_path))

puts problem1(input)

puts problem2(input)
