# frozen_string_literal: true

require_relative "lib"
include Year2022::Day14

input_path = File.join(__dir__, "input.txt")
input = process_input(File.read(input_path))

puts problem1(input)

input = process_input(File.read(input_path))

puts problem2(input)
