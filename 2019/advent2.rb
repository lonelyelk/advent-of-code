prog = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,6,23,2,13,23,27,1,27,13,31,1,9,31,35,1,35,9,39,1,39,5,43,2,6,43,47,1,47,6,51,2,51,9,55,2,55,13,59,1,59,6,63,1,10,63,67,2,67,9,71,2,6,71,75,1,75,5,79,2,79,10,83,1,5,83,87,2,9,87,91,1,5,91,95,2,13,95,99,1,99,10,103,1,103,2,107,1,107,6,0,99,2,14,0,0]

def compute(prg_src, noun, verb)
    prg = []
    prg_src.each_with_index do |v, i|
        prg[i] = if i == 1
            noun
        elsif i == 2
            verb
        else
            v
        end
    end

    index = 0

    while prg[index] != 99 do
        # puts "before: #{index} => #{prg[index]}"
        case prg[index]
        when 1
            prg[prg[index + 3]] = prg[prg[index + 1]] + prg[prg[index + 2]]
            index += 4
        when 2
            prg[prg[index + 3]] = prg[prg[index + 1]] * prg[prg[index + 2]]
            index += 4
        else
            raise "ERROR"
        end
        # puts "after: #{index} => #{prg[index]}"
    end

    prg[0]
end

puts compute(prog, 12, 2)

(0..99).each do |noun|
    (0..99).each do |verb|
        if compute(prog, noun, verb) == 19690720
            puts 100 * noun + verb
            exit 0
        end
    end
end
exit 1