def calc(expr)
  # puts expr
  if (md = expr.match(/^(.+?)? *\(([^(]+?)\) *(.+)?$/))
    calc("#{md[1]} #{calc(md[2])} #{md[3]}")
  elsif (md = expr.match(/^ *(\d+)( *[+*] *\d+ *)*$/))
    expr.scan(/([+*]) *(\d+)/).inject(md[1].to_i) do |res, (operation, num_str)|
      case operation
      when "+"
        res + num_str.to_i
      when "*"
        res * num_str.to_i
      else
        raise "Wrong operation"
      end
    end
  else
    raise "Expression mismatch '#{expr}'"
  end
end

def calc_plus(expr)
  # puts expr
  if (md = expr.match(/^(.+?)? *\(([^(]+?)\) *(.+)?$/))
    calc_plus("#{md[1]} #{calc_plus(md[2])} #{md[3]}")
  elsif (md = expr.match(/^(.+?)? *((\d+) *\+ *(\d+)) *(.+)?$/))
    calc_plus("#{md[1]} #{md[3].to_i + md[4].to_i} #{md[5]}")
  elsif (md = expr.match(/^ *(\d+)( *\* *\d+ *)*$/))
    expr.scan(/([+*]) *(\d+)/).inject(md[1].to_i) do |res, (operation, num_str)|
      case operation
      when "+"
        res + num_str.to_i
      when "*"
        res * num_str.to_i
      else
        raise "Wrong operation"
      end
    end
  elsif (md = expr.match(/^ *(\d+) *$/))
    md[1].to_i
  else
    raise "Expression mismatch '#{expr}'"
  end
end
