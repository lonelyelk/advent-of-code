# frozen_string_literal: true

# https://adventofcode.com/2025/day/11
module Year2025
  module Day11
    def process_input(str)
      str.split("\n").each_with_object({}) do |line, acc|
        key, values = line.split(/: ?/)
        acc[key] = values.split(/ /)
      end
    end

    def problem1(input)
      state = init_state1(input)
      until state.keys == ["out"]
        state = state.each_with_object(Hash.new(0)) do |(out, count), acc|
          input.key?(out) ? input[out].each { |o| acc[o] += count } : acc[out] += count
        end
      end
      state["out"]
    end

    def problem2(input)
      state = init_state2(input)
      until state.keys == ["out"]
        state = state.each_with_object(hash_hash) do |(out, counter), acc|
          if input.key?(out)
            input[out].each do |o|
              case o
              when "dac"
                acc[o]["dacfft"] += counter["fft"] + counter["dacfft"]
                acc[o]["dac"] += counter["+++"]
              when "fft"
                acc[o]["dacfft"] += counter["dac"] + counter["dacfft"]
                acc[o]["fft"] += counter["+++"]
              else
                %w[dacfft dac fft +++].each { |key| acc[o][key] += counter[key] }
              end
            end
          else
            %w[dacfft dac fft +++].each { |key| acc[out][key] += counter[key] }
          end
        end
      end
      state["out"]["dacfft"]
    end

    private

    def init_state1(input)
      input["you"].each_with_object(Hash.new(0)) do |out, acc|
        acc[out] += 1
      end
    end

    def hash_hash
      Hash.new { |h, k| h[k] = Hash.new(0) }
    end

    def init_state2(input)
      input["svr"].each_with_object(hash_hash) do |out, acc|
        key = %w[dac fft].include?(out) ? out : "+++"
        acc[out][key] += 1
      end
    end
  end
end
