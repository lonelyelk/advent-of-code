def parse_input(input)
  input.split("\n").reject(&:empty?).map do |line|
    md = line.match(/^(.+) \(contains (.+)\)/)
    {
      ingredients: md[1].split,
      allergens: md[2].split(", "),
    }
  end
end

def possible_allergens(parsed)
  parsed.each_with_object({}) do |food, allerg|
    food[:allergens].each do |allerg_name|
      if allerg.key?(allerg_name)
        allerg[allerg_name] = allerg[allerg_name] & food[:ingredients]
      else
        allerg[allerg_name] = food[:ingredients]
      end
    end
  end
end

def no_allergens(parsed, possible)
  parsed.map { |food| food[:ingredients] }.flatten - possible.values.flatten
end

def definite_allergens(possible)
  while possible.values.any? { |ingredients_list| ingredients_list.length > 1 } do
    definite = possible.values.select { |ingredients_list| ingredients_list.length == 1 }.flatten
    possible = possible.each_with_object({}) do |(allerg_name, ingredients_list), pos|
      pos[allerg_name] =
        if ingredients_list.length > 1
          ingredients_list - definite
        else
          ingredients_list
        end
    end
  end
  possible.keys.sort.map { |allerg_name| possible[allerg_name].first }.join(",")
end
