class GameOfSeats
  attr_reader :state

  def initialize(input)
    @state = input.split("\n").reject(&:empty?).map { |row| "#{row}W" }
    @state.push("W" * @state.last.length)
  end

  def stabilize!
    new_state = step!
    while new_state.each_with_index.any? { |row, y| state[y] != row }
      @state = new_state
      new_state = step!
    end
    @state = new_state
    new_state.inject(0) { |sum, row| sum + row.chars.count { |c| c == "#" } }
  end

  def to_s
    state[0..-2].map { |row| row[0..-2] }.join("\n")
  end

  def step!
    new_state = []
    state[0..-2].each_with_index do |row, y|
      row[0..-2].chars.each_with_index do |seat, x|
        if seat == "."
          new_state[y] = "#{new_state[y]}."
          next
        end

        occupied_num = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]].inject(0) do |sum, (dx, dy)|
          if state[y + dy][x + dx] == "#"
            sum + 1
          else
            sum
          end
        end

        if seat == "L" && occupied_num == 0
          new_state[y] = "#{new_state[y]}#"
        elsif seat == "#" && occupied_num >= 4
          new_state[y] = "#{new_state[y]}L"
        else
          new_state[y] = "#{new_state[y]}#{seat}"
        end
      end
      new_state[y] = "#{new_state[y]}W"
    end
    new_state.push("W" * state.last.length)
    new_state
  end
end

class GameOfSeats2
  attr_reader :state

  def initialize(input)
    @state = input.split("\n").reject(&:empty?).map { |row| "#{row}W" }
    @state.push("W" * @state.last.length)
  end

  def stabilize!
    new_state = step!
    while new_state.each_with_index.any? { |row, y| state[y] != row }
      @state = new_state
      new_state = step!
    end
    @state = new_state
    new_state.inject(0) { |sum, row| sum + row.chars.count { |c| c == "#" } }
  end

  def to_s
    state[0..-2].map { |row| row[0..-2] }.join("\n")
  end

  def step!
    new_state = []
    state[0..-2].each_with_index do |row, y|
      row[0..-2].chars.each_with_index do |seat, x|
        if seat == "."
          new_state[y] = "#{new_state[y]}."
          next
        end

        occupied_num = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]].inject(0) do |sum, (dx, dy)|
          c = 1
          s = state[y + c*dy][x + c*dx]
          add = 0
          while %[# .].include?(s)
            if s == "#"
              add = 1
              break
            end
            c += 1
            s = state[y + c*dy][x + c*dx]
          end
          sum + add
        end

        if seat == "L" && occupied_num == 0
          new_state[y] = "#{new_state[y]}#"
        elsif seat == "#" && occupied_num >= 5
          new_state[y] = "#{new_state[y]}L"
        else
          new_state[y] = "#{new_state[y]}#{seat}"
        end
      end
      new_state[y] = "#{new_state[y]}W"
    end
    new_state.push("W" * state.last.length)
    new_state
  end
end
