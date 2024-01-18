# frozen_string_literal: true

# https://adventofcode.com/2023/day/25
module Year2023
  module Day25
    def process_input(str)
      str.split("\n").each_with_object(Hash.new { |h, k| h[k] = {} }) do |line, graph|
        md = line.match(/(\w+): (.+)/)
        node = md[1]
        nodes = md[2].split
        nodes.each do |n|
          graph[node][n] = true
          graph[n][node] = true
        end
      end
    end

    # This is very slow
    def problem1(input)
      nodes = input.keys.each_with_index.to_h
      laplacian = Matrix.diagonal(*nodes.map { |node, _| input[node].size })
      nodes.each do |node, index|
        input[node].each do |adj_node, _|
          laplacian[index, nodes[adj_node]] = -1
        end
      end
      ev_dec = Matrix::EigenvalueDecomposition.new(laplacian)
      v = ev_dec.eigenvectors[1]
      v.count(&:positive?) * v.count(&:negative?)
    end

    def problem2(input); end
  end
end
