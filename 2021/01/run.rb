# frozen_string_literal: true

require_relative "lib"
include Day01

input = process_input(File.read("input.txt"))

puts problem1(input)

puts problem2(input)
