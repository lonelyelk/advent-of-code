def trees_count(input, dx = 3, dy = 1)
  x = y = 0
  cnt = 0
  while y < input.length - dy do
    x += dx
    y += dy
    break unless input[y]

    cnt += 1 if input[y][x % input[y].length] == '#'
  end
  cnt
end
