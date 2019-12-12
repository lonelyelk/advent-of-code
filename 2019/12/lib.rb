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

  def axis_stopped?(n)
    moons.all? { |m| m.vel[n] == 0 }
  end
end

def return_to_start_steps(sys)
  steps_to_stop = Array.new(3, 0)
  steps = 0
  while steps_to_stop.any? { |num| num == 0 }
    steps += 1
    sys.step!
    steps_to_stop.each_with_index do |num, i|
      next unless num == 0
      steps_to_stop[i] = steps if sys.axis_stopped?(i)
    end
  end
  steps_to_stop.inject(&:lcm) * 2
end
