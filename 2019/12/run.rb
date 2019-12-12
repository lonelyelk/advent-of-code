require_relative "lib"

sys = MoonSystem.new(File.read("input.txt").chomp.split("\n"))
sys.steps!(1000)

puts sys.tot

sys = MoonSystem.new(File.read("input.txt").chomp.split("\n"))

puts return_to_start_steps(sys)
