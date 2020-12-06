def any_group_yes_count(answers)
  answers.gsub("\n", "").chars.uniq.length
end

def all_group_yes_count(answers)
  answers.split("\n").map(&:chars).inject(&:&).length
end

def yes_count(input, rule)
  input.split("\n\n").map { |str| send("#{rule}_group_yes_count", str) }.inject(&:+)
end
