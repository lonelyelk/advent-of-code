# frozen_string_literal: true

module Day04
  def process_input(str)
    numbers, *boards = str.split("\n\n").reject(&:empty?)
    [numbers.chomp.split(",").map(&:to_i)] +
      boards.map do |b|
        board = b.chomp.split("\n").map { |row| row.split(/\s+/).reject(&:empty?).map(&:to_i) }
        board + board.transpose
      end
  end

  def problem1(input)
    numbers, *boards = input
    numbers.each do |num|
      boards = boards.map do |board|
        board.map { |rc| rc.reject { |n| n == num } }
      end
      winning_board = boards.detect { |board| board.any?(&:empty?) }
      return winning_board.reject(&:empty?).inject(0) { |acc, row| acc + row.inject(&:+) } * num / 2 if winning_board
    end
  end

  def problem2(input)
    numbers, *boards = input
    numbers.each do |num|
      boards = boards.map do |board|
        board.map { |rc| rc.reject { |n| n == num } }
      end
      if boards.size > 1
        boards = boards.reject { |board| board.any?(&:empty?) }
      elsif boards.first.any?(&:empty?)
        return boards.first.reject(&:empty?).inject(0) do |acc, row|
                 acc + row.inject(&:+)
               end * num / 2
      end
    end
  end
end
