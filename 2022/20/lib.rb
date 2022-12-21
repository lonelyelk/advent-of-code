# frozen_string_literal: true

# https://adventofcode.com/2022/day/20
module Year2022
  module Day20
    class Node
      attr_accessor :data, :index, :next_node

      def initialize(index:, data:, next_node: nil)
        @index = index
        @data = data
        @next_node = next_node
      end

      def to_s
        data.to_s
      end
    end

    class CLinkedList
      attr_reader :node, :length

      def initialize(data_points:)
        @node = Node.new(index: 0, data: data_points.shift)
        @length = 0
        last_node = data_points.inject(@node) do |prev_node, data|
          @length += 1
          prev_node.next_node = Node.new(index: @length, data:)
        end
        @length += 1
        last_node.next_node = @node
      end

      def decrypt
        @length.times do |i|
          find(index: i)
          move(diff: node.data)
        end
        @node = node.next_node until node.data.zero?
      end

      def find(index:)
        @node = node.next_node while node.index != index
      end

      # rubocop:disable Metrics/AbcSize
      def move(diff:)
        diff %= (length - 1)
        return if diff.zero?

        to_rotate = node
        gap_node = node.next_node
        diff.times { to_rotate = to_rotate.next_node }
        go_further = to_rotate
        (length - diff - 1).times { go_further = go_further.next_node }
        node.next_node = to_rotate.next_node
        to_rotate.next_node = node
        go_further.next_node = gap_node
      end
      # rubocop:enable Metrics/AbcSize

      def data_at(position:)
        pos = position % length
        n = node
        pos.times { n = n.next_node }
        n.data
      end

      def to_s
        n = node
        length.times.map do
          s = n.to_s
          n = n.next_node
          s
        end.join(", ")
      end
    end

    def process_input(str)
      str.split("\n").reject(&:empty?).map(&:to_i)
    end

    def problem1(input)
      code = CLinkedList.new(data_points: input.dup)

      code.decrypt

      [1000, 2000, 3000].map { |pos| code.data_at(position: pos) }.sum
    end

    def problem2(input)
      code = CLinkedList.new(data_points: input.map { |n| n * 811_589_153 })

      10.times { code.decrypt }

      [1000, 2000, 3000].map { |pos| code.data_at(position: pos) }.sum
    end
  end
end
