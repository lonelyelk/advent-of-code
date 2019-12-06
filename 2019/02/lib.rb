def compute(prg)
  index = 0
  while prg[index] != 99 do
    case prg[index]
    when 1
      prg[prg[index+3]] = prg[prg[index+1]] + prg[prg[index+2]]
      index += 4
    when 2
      prg[prg[index+3]] = prg[prg[index+1]] * prg[prg[index+2]]
      index += 4
    else
      raise "ERROR"
    end
  end
  prg
end

def dup_with_noun_and_verb(src, noun, verb)
  prg = src.dup
  prg[1] = noun
  prg[2] = verb
  prg
end

def find_noun_and_verb(src, res)
  (0..99).each do |noun|
    (0..99).each do |verb|
      return 100*noun + verb if compute(dup_with_noun_and_verb(src, noun, verb))[0] == res
    end
  end
end
