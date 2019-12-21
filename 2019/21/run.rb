require_relative "lib"

prog = File.read("input.txt").chomp.split(",").map(&:to_i)

script = <<SCRIPT
NOT A T
OR T J
NOT B T
OR T J
NOT C T
OR T J
NOT D T
NOT T T
AND T J
SCRIPT

walk(prog, script)

script = <<SCRIPT
OR A J
AND B J
AND C J
NOT J J
AND D J
NOT E T
AND H T
OR E T
AND T J
SCRIPT
run(prog, script)
