# frozen_string_literal: true

# https://adventofcode.com/2023/day/23
module Year2023
  # rubocop:disable Metrics/ModuleLength, Metrics/MethodLength, Metrics/AbcSize
  module Day23
    STEPS = {
      "^" => Complex(-1, 0),
      ">" => Complex(0, 1),
      "v" => Complex(1, 0),
      "<" => Complex(0, -1),
    }.freeze

    def process_input(str)
      str.split("\n")
    end

    def problem1(input)
      start = Complex(0, 1)
      finish = Complex(input.size - 1, input.last.size - 2)
      path = { current: start, walk: { start => true } }
      paths = [path]
      max_length = 0
      until paths.empty?
        paths = paths.each_with_object([]) do |pth, next_paths|
          STEPS.each do |dir, diff|
            pos = pth[:current] + diff
            f = forest(input, pos)
            next if f == "#" || (f != "." && f != dir) || pth[:walk][pos]

            if pos == finish
              max_length = [max_length, pth[:walk].size].max
            else
              next_paths.push({ current: pos, walk: pth[:walk].merge(pos => true) })
            end
          end
        end
      end
      max_length
    end

    def problem2(input)
      graph = build_graph(input)
      paths = [{ nodes: { "START" => true }, current: "START", length: 0 }]
      max_finish = 0
      max_path = {}
      until paths.all? { |pth| pth[:current] == "FINISH" }
        paths = paths.flat_map do |pth|
          if pth[:current] == "FINISH"
            if max_finish <= pth[:length]
              max_finish = pth[:length]
              pth
            end
          else
            # next_paths(graph, pth)
            next_paths(graph, pth).select do |npth|
              if max_path[npth.except(:length)].nil? || max_path[npth.except(:length)] <= npth[:length]
                max_path[npth.except(:length)] = npth[:length]
              end
            end
          end
        end.compact
        # p paths.size
      end
      paths.map { |pth| pth[:length] }.max
    end

    private

    def next_paths(graph, path)
      graph[path[:current]].except(*path[:nodes].keys).map do |node, dist|
        { nodes: path[:nodes].merge(node => true), current: node, length: path[:length] + dist }
      end
    end

    def forest(input, position)
      r = position.real
      i = position.imag
      return "#" if r % input.size != r || i % input.first.size != i

      input[r][i]
    end

    def build_graph(input)
      start = 1i
      finish = Complex(input.size - 1, input.last.size - 2)
      paths = [[start]]
      current = { start => true }
      next_label = "A"
      labels = { start => "START", finish => "FINISH" }
      until current.all? { |pos, _| pos == finish }
        current = {}
        paths = paths.each_with_object([]) do |path, next_paths|
          curr = path.last
          next_positions = STEPS.map do |_, diff|
            np = curr + diff
            next if forest(input, np) == "#" || path.include?(np)

            np
          end.compact
          if next_positions.size == 1
            next_paths.push([*path, next_positions.first])
            current[next_positions.first] = true
          elsif next_positions.size > 1
            next_paths.push(path)
            unless labels[curr]
              labels[curr] = next_label
              next_label = next_label.succ
              next_positions.each do |pos|
                current[pos] = true
                next_paths.push([curr, pos])
              end
            end
          else
            next_paths.push(path)
          end
        end
      end
      paths.each_with_object({}) do |path, g|
        from_node = path.first
        to_node = path.last
        g[labels[from_node]] ||= {}
        g[labels[from_node]][labels[to_node]] = path.size - 1
        g[labels[to_node]] ||= {}
        g[labels[to_node]][labels[from_node]] = path.size - 1
      end
    end
  end
  # rubocop:enable Metrics/ModuleLength, Metrics/MethodLength, Metrics/AbcSize
end
