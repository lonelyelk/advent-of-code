class Chemical
  attr_reader :name, :amount

  def initialize(name:, amount:)
    @name = name
    @amount = amount.to_i
  end

  def fuel?
    name == "FUEL"
  end
end

class Reaction
  attr_reader :result, :ingredients

  def initialize(line)
    md = line.match(/(.+) => ([0-9]+) ([A-Z]+)/)
    @result = Chemical.new(name: md[3], amount: md[2])
    @ingredients = md[1].split(", ").map do |str|
      md = str.match(/([0-9]+) ([A-Z]+)/)
      Chemical.new(name: md[2], amount: md[1])
    end
  end

  def produce?(name)
    result.name == name
  end

  def produce_fuel?
    result.fuel?
  end
end

class Chain
  def initialize(lines)
    @reactions = lines.map { |line| Reaction.new(line) }
  end
  
  def ore_amount(fuel = 1)
    fuel_reaction = @reactions.detect(&:produce_fuel?)
    chain = fuel_reaction.ingredients.each_with_object({}) do |chemical, obj|
      obj[chemical.name] = chemical.amount * fuel
    end
    chain_reactions = chain.keys.map { |name| @reactions.detect { |reaction| reaction.produce?(name) } }.compact
    while !chain_reactions.empty?
      chain_setup = {required: {}, produced: {}}
      chain_reactions.each do |reaction|
        mult = chain[reaction.result.name] / reaction.result.amount +
          (chain[reaction.result.name] % reaction.result.amount == 0 ? 0 : 1)
        chain_setup[:produced][reaction.result.name] = reaction.result.amount * mult
        reaction.ingredients.each_with_object(chain_setup) do |chemical, obj|
          obj[:required][chemical.name] ||= 0
          obj[:required][chemical.name] += chemical.amount * mult
        end
      end
      chain_setup[:required].each do |name, amount|
        chain[name] ||= 0
        chain[name] += amount
      end
      chain_setup[:produced].each do |name, amount|
        chain[name] ||= 0
        chain[name] -= amount
      end
      chain_reactions = chain.select { |_, amount| amount > 0 }.keys.map { |name| @reactions.detect { |reaction| reaction.produce?(name) } }.compact
    end
    chain["ORE"]
  end

  def fuel_amount(ore_capacity)
    ore_for_one = ore_amount
    return 0 if ore_for_one > ore_capacity

    fuel = ore_capacity / ore_for_one
    ore = ore_capacity - ore_amount(fuel)
    while ore >= ore_for_one
      fuel += fuel_amount(ore)
      ore = ore_capacity - ore_amount(fuel)
    end
    while ore_capacity >= ore_amount(fuel)
      fuel += 1
    end
    fuel - 1
  end
end
