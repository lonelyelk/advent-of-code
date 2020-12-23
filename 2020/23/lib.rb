def crab_game(cups, moves)
  cups = cups.chars.map(&:to_i)
  current = cups[0]
  moves.times do
    removed = cups.slice!(1, 3)
    destination = current
    while destination == current || !cups.include?(destination)
      destination -= 1
      if destination == 0
        destination = cups.max
      end
    end
    cups.insert(cups.index(destination)+1, *removed)
    cups.rotate!
    current = cups[0]
  end
  cups.rotate(cups.index(1))[1..-1].join
end

class Node
  attr_accessor :next_node
  attr_reader :value

  def initialize(value)
    @value = value
  end
end

class NodeList
  def initialize(seed, max)
    @nodes = {}
    @max = max
    @min = seed.min
    prev_node = nil
    (@min..@max).each do |i|
      value = i <= seed.length ? seed[i-1] : i
      node = Node.new(value)
      if prev_node.nil?
        @current = node
      else
        prev_node.next_node = node
      end
      @nodes[value] = node
      prev_node = node
    end
    @target = @current.value
    prev_node.next_node = @current
  end

  def move!
    removed_node = @current.next_node
    removed_nodes = [removed_node, removed_node.next_node, removed_node.next_node.next_node]
    values = removed_nodes.map(&:value)
    @current.next_node = removed_nodes.last.next_node
    @target -= 1
    while !@nodes.key?(@target) || values.include?(@target)
      if @target < @min
        @target = @max
      else
        @target -= 1
      end
    end
    next_node = @nodes[@target].next_node
    @nodes[@target].next_node = removed_nodes.first
    removed_nodes.last.next_node = next_node
    @current = @current.next_node
    @target = @current.value
  end

  def after_one
    [
      @nodes[1].next_node.value,
      @nodes[1].next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.next_node.next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.next_node.next_node.next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.next_node.next_node.next_node.next_node.next_node.value,
      @nodes[1].next_node.next_node.next_node.next_node.next_node.next_node.next_node.next_node.next_node.value,
    ]
  end

  def cups_mult
    @nodes[1].next_node.value * @nodes[1].next_node.next_node.value
  end
end

def crab_game2(cups, moves)
  cups = NodeList.new(cups.chars.map(&:to_i), 1000000)
  moves.times do |i|
    cups.move!
  end
  cups.cups_mult
end
