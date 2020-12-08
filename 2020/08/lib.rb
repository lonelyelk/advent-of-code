class Assembly
  attr_reader :instructions, :accumulator

  def initialize(program)
    @instructions = program.scan(/(\w{3}) ([-+]\d+)\n/).map do |cmd, arg|
      {
        cmd: [cmd.to_sym, arg.to_i],
        exec: 0,
      }
    end
    @accumulator = 0
  end

  def execute
    index = 0
    while index < instructions.length
      return accumulator if instructions[index][:exec] > 0

      instructions[index][:exec] += 1
      case instructions[index][:cmd][0]
      when :acc
        @accumulator += instructions[index][:cmd][1]
        index += 1
      when :jmp
        index += instructions[index][:cmd][1]
      else
        index += 1
      end
    end
    accumulator
  end
end
