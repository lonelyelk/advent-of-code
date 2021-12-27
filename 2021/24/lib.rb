# frozen_string_literal: true

# https://adventofcode.com/2021/day/24
module Day24
  def process_input(str)
    str.split("\n").reject(&:empty?).map(&:split)
  end

  def run(program, inp: [], w: 0, x: 0, y: 0, z: 0)
    registers = { "w" => w, "x" => x, "y" => y, "z" => z }
    program.each do |instr|
      case instr
      in "inp", *args
        registers[args.first] = inp.shift.to_i
        # puts "RUN: #{registers[args.first]} #{registers["z"]}"
      in "add", *args
        registers[args[0]] = registers[args[0]] + (registers[args[1]] || args[1].to_i)
      in "mul", *args
        registers[args[0]] = registers[args[0]] * (registers[args[1]] || args[1].to_i)
      in "div", *args
        registers[args[0]] = registers[args[0]] / (registers[args[1]] || args[1].to_i)
      in "mod", *args
        registers[args[0]] = registers[args[0]] % (registers[args[1]] || args[1].to_i)
      in "eql", *args
        registers[args[0]] = registers[args[0]] == (registers[args[1]] || args[1].to_i) ? 1 : 0
      else
        raise instr.inspect
      end
    end
    registers
  end

  def serial_check(num)
    z = 0
    dx = [14,13,15,13,-2,10,13,-15,11,-9,-9,-7,-4,-6]
    dz = [1,1,1,1,26,1,1,26,1,26,26,26,26,26]
    dw = [0,12,14,0,3,15,11,12,1,12,3,10,14,12]
    num.digits.reverse.each_with_index do |w, i|
      # puts "CHECK: #{w} #{z}"
      x = z % 26 + dx[i]
      z /= dz[i]
      if w != x
        z *= 26
        z += w + dw[i]
      end
    end
    z
  end

  def problem1(input)
    9999.downto(1111).each do |num1|
      next if num1.digits.any?(&:zero?)

      mod1 = serial_check(num1) % 26
      if mod1 > 2 && mod1 < 12
        99.downto(11).each do |num2|
          next if num2.digits.any?(&:zero?)

          mod2 = serial_check((num1 * 10 + mod1 - 2) * 100 + num2) % 26
          if mod2 > 15
            9.downto(1).each do |num3|
              num_so_far = (((num1 * 10 + mod1 - 2) * 100 + num2) * 10 + mod2 - 15) * 10 + num3
              failed = false

              [9, 9, 7, 4, 6].each do |n|
                mod_so_far = serial_check(num_so_far) % 26
                unless mod_so_far > n && mod_so_far < n + 10
                  failed = true
                  break
                end

                num_so_far = num_so_far * 10 + mod_so_far - n
              end

              return num_so_far unless failed
            end
          end
        end
      end
    end
  end

  def problem2(input)
    1111.upto(9999).each do |num1|
      next if num1.digits.any?(&:zero?)

      mod1 = serial_check(num1) % 26
      if mod1 > 2 && mod1 < 12
        11.upto(99).each do |num2|
          next if num2.digits.any?(&:zero?)

          mod2 = serial_check((num1 * 10 + mod1 - 2) * 100 + num2) % 26
          if mod2 > 15
            1.upto(9).each do |num3|
              num_so_far = (((num1 * 10 + mod1 - 2) * 100 + num2) * 10 + mod2 - 15) * 10 + num3
              failed = false

              [9, 9, 7, 4, 6].each do |n|
                mod_so_far = serial_check(num_so_far) % 26
                unless mod_so_far > n && mod_so_far < n + 10
                  failed = true
                  break
                end

                num_so_far = num_so_far * 10 + mod_so_far - n
              end

              return num_so_far unless failed
            end
          end
        end
      end
    end
  end
end
