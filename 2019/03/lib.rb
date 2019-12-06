def path(w)
  w.inject([]) do |acc, dir|
      pt = acc.last || [0, 0]
      case dir[0]
      when 'U'
          acc + (1..(dir[1..-1].to_i)).map{ |i| [pt[0], pt[1] + i] }
      when 'D'
          acc + (1..(dir[1..-1].to_i)).map{ |i| [pt[0], pt[1] - i] }
      when 'R'
          acc + (1..(dir[1..-1].to_i)).map{ |i| [pt[0] + i, pt[1]] }
      when 'L'
          acc + (1..(dir[1..-1].to_i)).map{ |i| [pt[0] - i, pt[1]] }
      else
          raise "ERROR"
      end
  end
end

def intersections(p1, p2)
  (p1 - (p1 - p2))
end

def min_distance(w1, w2)
  ints = intersections(path(w1), path(w2))
  ints.map { |pt| pt.map(&:abs).inject(&:+) }.sort.first
end

def min_steps(w1, w2)
  p1 = path(w1)
  p2 = path(w2)
  ints = intersections(p1, p2)
  ints.map { |pt| p1.index(pt) + p2.index(pt) + 2 }.sort.first
end
