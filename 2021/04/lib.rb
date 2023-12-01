# frozen_string_literal: true

# https://adventofcode.com/2021/day/4
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
      boards = mark_number(boards, num)
      sum = winner_sum(boards)
      return sum * num if sum
    end
  end

  def problem2(input)
    numbers, *boards = input
    numbers.each do |num|
      boards = mark_number(boards, num)
      if boards.size > 1
        boards = boards.reject { |board| board.any?(&:empty?) }
      else
        sum = winner_sum(boards)
        return sum * num if sum
      end
    end
  end

  protected

  def mark_number(boards, num)
    boards.map do |board|
      board.map { |rc| rc.reject { |n| n == num } }
    end
  end

  def winner_sum(boards)
    winning_board = boards.detect { |board| board.any?(&:empty?) }
    unmarked_board_sum(winning_board) if winning_board
  end

  def unmarked_board_sum(board)
    board.reject(&:empty?).inject(0) { |acc, row| acc + row.inject(&:+) } / 2
  end
end
