def valid_passwords_count(list)
  list.inject(0) do |valid_cnt, rule|
    if (md = rule.match(/(\d+)-(\d+) (.): (.+)/))
      min = md[1].to_i
      max = md[2].to_i
      letter_cnt = md[4].count(md[3])
      valid_cnt += 1 if letter_cnt.between?(min, max)
    end
    valid_cnt
  end
end

def new_valid_passwords_count(list)
  list.inject(0) do |valid_cnt, rule|
    if (md = rule.match(/(\d+)-(\d+) (.): (.+)/))
      pos1 = md[1].to_i - 1
      pos2 = md[2].to_i - 1
      valid_cnt += 1 if (md[4][pos1] == md[3]) ^ (md[4][pos2] == md[3])
    end
    valid_cnt
  end
end
