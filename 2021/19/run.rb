# frozen_string_literal: true

require_relative "lib"
include Day19

input_path = File.join(__dir__, "input.txt")
input = process_input(File.read(input_path))

p problem12(input)
