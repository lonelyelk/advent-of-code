def joltage_diffs(adapters)
  sorted_adapters = adapters.sort
  sorted_adapters.each_with_object(1 => 0, 2 => 0, 3 => 1)
    .with_index do |(adapter, diffs), index|
      if index == 0
        diffs[adapter] += 1
      else
        diffs[adapter - sorted_adapters[index-1]] += 1
      end
    end
end

def solutions_count(adapters)
  sorted_adapters = [0] + adapters.sort + [adapters.max + 3]
  split_into_groups(sorted_adapters).inject(1) do |acc, group|
    if group.length < 3
      acc
    else
      other = (1..(group.length-2)).inject(0) do |sum, num|
        sum + group[1..-2].combination(num).count do |subgroup|
          group_valid?(group - subgroup)
        end
      end
      acc * (1 + other)
    end
  end
end

def split_into_groups(adapters)
  adapters.inject([[]]) do |acc, adapter|
    if acc.last.last.nil? || adapter - acc.last.last < 3
      acc.last.push(adapter)
    else
      acc.push([adapter])
    end
    acc
  end
end

def group_valid?(group)
  group[0..-2].each_with_index.all? do |adapter, index|
    group[index + 1] - adapter <= 3
  end
end
