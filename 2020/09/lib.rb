def is_a_sum?(num, arr)
  arr[0..-2].each_with_index do |n, i|
    arr[(i+1)..-1].each do |m|
      return true if n + m == num
    end
  end
  false
end

def first_invalid_num(data, preamble_size)
  index = preamble_size
  while index < data.length
    return data[index] unless is_a_sum?(data[index], data[(index - preamble_size), preamble_size])

    index += 1
  end
end

def subset_with_sum(data, sum)
  start = 0
  finish = 1
  subset = data[start..finish]
  subset_sum = subset.inject(&:+)
  while subset_sum != sum
    finish += 1
    while subset_sum + data[finish] > sum
      subset.shift
      subset_sum -= data[start]
      start += 1
    end
    subset.push(data[finish])
    subset_sum += data[finish]
  end
  subset
end
