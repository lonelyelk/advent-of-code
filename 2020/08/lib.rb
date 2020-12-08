class Assembly
  attr_reader :instructions, :accumulator

  def initialize(program)
    @program = program
    @instructions = setup
  end

  def execute
    index = 0
    while index < instructions.length
      return [:fail, accumulator] if instructions[index][0] > 0

      instructions[index][0] += 1
      case instructions[index][1]
      when :acc
        @accumulator += instructions[index][2]
        index += 1
      when :jmp
        index += instructions[index][2]
      else
        index += 1
      end
    end
    [:success, accumulator]
  end

  def fix
    result = execute
    index = -1
    while result[0] == :fail
      @instructions = setup
      index = @instructions.find_index.with_index do |instruction, i|
        [:nop, :jmp].include?(instruction[1]) && i > index
      end
      if @instructions[index][1] == :jmp
        @instructions[index][1] = :nop 
      else
        @instructions[index][1] = :jmp
      end
      result = execute
    end
    result
  end

  private

  def setup
    @accumulator = 0
    @program.scan(/(\w{3}) ([-+]\d+)\n?/).map do |cmd, arg|
      [0, cmd.to_sym, arg.to_i]
    end
  end
end
