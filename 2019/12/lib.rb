class Moon
  attr_reader :pos, :vel

  def initialize(line)
    md = line.match(/x=(-?\d+).+y=(-?\d+).+z=(-?\d+)/i)
    @pos = md[1..3].map(&:to_i)
    @vel = Array.new(3, 0)
  end

  def apply_gravity!(moon)
    @vel = vel.map.with_index { |v, i| v + (moon.pos[i] <=> pos[i]) }
  end

  def apply_velocity!
    @pos = pos.zip(vel).map { |arr| arr.inject(&:+) }
  end

  def kin
    vel.map(&:abs).inject(&:+)
  end

  def pot
    pos.map(&:abs).inject(&:+)
  end

  def tot
    kin * pot
  end
end

class MoonSystem
  attr_reader :moons

  def initialize(lines)
    @moons = lines.map { |line| Moon.new(line) }
  end

  def step!
    moons.each_with_index do |moon, index|
      moons.each { |m| moon.apply_gravity!(m) }
    end
    moons.each { |m| m.apply_velocity! }
  end

  def steps!(n)
    n.times { step! }
  end

  def tot
    moons.map(&:tot).inject(&:+)
  end
end
