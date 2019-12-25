class Pathfinder
  def initialize
    @cached_tails = {}
  end

  def next_search(source_map)
    map = source_map.map(&:dup)
    y = map.index { |line| line.include?("@") }
    x = map[y].index("@")
    steps = 0
    count = 0
    new_count = map.inject(0) { |acc, line| acc + line.count("@") }
    next_steps = {}
    while count < new_count do
      count = new_count
      map = map.map.with_index do |line, y|
        line.map.with_index do |c, x|
          if c == "#"
            c
          elsif map[y-1][x] == "@" || map[y+1][x] == "@" || map[y][x-1] == "@" || map[y][x+1] == "@"
            if c == "."
              "@"
            elsif /[a-z]/i.match?(map[y][x]) && !next_steps.key?(c)
              next_steps[c] = steps + 1
              c
            else
              c
            end
          else
            c
          end
        end
      end
      steps += 1
      new_count = map.inject(0) { |acc, line| acc + line.count("@") }
    end
    # map.each do |line|
    #   puts line.join
    # end
    # puts next_steps.inspect
    next_steps
  end

  def build_steps_map(source_map)
    source_map.inject({}) do |steps_map, line|
      line.each_with_object(steps_map) do |char, s_m|
        next unless /[a-z]/i.match?(char)
        map = source_map.map do |l|
          l.map do |c|
            if c == "@"
              "."
            elsif c == char
              "@"
            else
              c
            end
          end
        end
        s_m[char] ||= {}
        key_steps = next_search(map)
        key_steps.each do |c, steps|
          s_m[char][c] = steps if char.downcase != c && (!s_m[char].key?(c) || steps < s_m[char][c])
        end
      end
    end
  end

  def resolve_key_door_tail(required_keys, steps_map, key_door, shift = 0, chain = [key_door])
    resolved = steps_map[key_door].each_with_object({}) do |(k_d, count), steps|
      next if chain.include?(k_d)
      if !required_keys.include?(k_d.downcase)
        resolve_key_door_tail(required_keys, steps_map, k_d, count + shift, chain + [k_d]).each do |k_r, v_r|
          steps[k_r] = v_r if !steps.key?(k_r) || steps[k_r] > v_r
        end
      elsif /[a-z]/.match?(k_d) && (!steps.key?(k_d) || steps[k_d] > count + shift)
        steps[k_d] = count + shift
      end
    end
    # puts "RESOLVE: #{key_door} RK: #{required_keys.inspect}; shift: #{shift}; chain: #{chain}; resolved: #{resolved.inspect}"
    resolved
  end

  def steps_map_with_open(steps_map, key)
    # puts "REMOVE: #{key} from #{steps_map.inspect}"
    door = key.upcase
    resolved_key = steps_map[key].dup
    if resolved_key[door]
      dist = resolved_key.delete(door)
      steps_map[door].each do |k, v|
        next if k == key
        resolved_key[k] = v + dist if !resolved_key.key?(k) || resolved_key[k] > v + dist
      end
    end
    resolved_door = steps_map.key?(door) ? steps_map[door].dup : {}
    if resolved_door[key]
      dist = resolved_door.delete(key)
      steps_map[key].each do |k, v|
        next if k == door
        resolved_door[k] = v + dist if !resolved_door.key?(k) || resolved_door[k] > v + dist
      end
    end
    removed = steps_map.each_with_object({}) do |(key_door, steps), open_door_map|
      open_door_map[key_door] = steps.each_with_object({}) do |(k_d, count), new_steps|
        if k_d == key
          resolved_key.each do |k_d_b, cnt|
            next if key_door == k_d_b
            if !new_steps.key?(k_d_b) || new_steps[k_d_b] > count + cnt
              new_steps[k_d_b] = count + cnt
            end
          end
        elsif k_d == door
          resolved_door.each do |k_d_b, cnt|
            next if key_door == k_d_b
            if !new_steps.key?(k_d_b) || new_steps[k_d_b] > count + cnt
              new_steps[k_d_b] = count + cnt
            end
          end
        elsif !new_steps.key?(k_d) || new_steps[k_d] > count
          new_steps[k_d] = count
        end
      end
    end
    removed
  end

  def tail_path(required_keys, steps_map, steps, current_step)
    if required_keys.empty?
      return current_step
    elsif current_step.first && (key = current_step.first.first) && (tail = @cached_tails["#{key}_#{required_keys.sort.join}"])
      return current_step + tail
    end

    tail = steps.map do |k, c|
      if required_keys.include?(k)
        next_steps_map = steps_map_with_open(steps_map, k)
        next_steps = resolve_key_door_tail(required_keys, next_steps_map, k)
        tail_path(required_keys - [k], next_steps_map, next_steps, [[k, c]])
      end
    end.reject{ |pth| pth.nil? || pth.empty? }.min_by { |pth| pth.map { |pt| pt[1] }.inject(&:+) }
    return unless tail

    @cached_tails["#{key}_#{required_keys.sort.join}"] = tail
    current_step + tail
  end

  def tail_path_bots(required_keys, steps_map, bot_steps, current_step, bot_state)
    cache_prefix = bot_state.keys.sort.map { |bot| bot_state[bot] }.join
    if required_keys.empty?
      return current_step
    elsif (tail = @cached_tails["#{cache_prefix}_#{required_keys.sort.join}"])
      return current_step + tail
    end
    # puts "RK: #{required_keys.inspect}; SM: #{steps_map.inspect}; BS: #{bot_steps.inspect}; CS: #{current_step.inspect}; BOT_STATE: #{bot_state.inspect}; cached tails: #{@cached_tails.inspect}"

    tails = bot_steps.select { |_, s| s.keys.any? { |k| k.match?(/[a-z]/) } }.map do |b, s|
      s.select { |k, _| k.match?(/[a-z]/) }.map do |k, c|
        if required_keys.include?(k)
          next_steps_map = steps_map_with_open(steps_map, k)
          next_bot_steps = steps_map_with_open(steps_map.merge(bot_steps), k).select { |b, _| bot_steps.keys.include?(b) }
          next_bot_steps[b] = next_steps_map[k]
          tail_path_bots(required_keys - [k], next_steps_map, next_bot_steps, [[k, c]], bot_state.merge({b => k}))
        end
      end.reject do |pth|
        pth.nil? || pth.empty?
      end.min_by { |pth| pth.map { |pt| pt[1] }.inject(&:+) }
    end
    
    tail = tails.reject do |pth|
      pth.nil? || pth.empty?
    end.min_by { |pth| pth.map { |pt| pt[1] }.inject(&:+) }
    # puts "Ts: #{tails.inspect} T: #{tail}"

    return unless tail

    @cached_tails["#{cache_prefix}_#{required_keys.sort.join}"] = tail
    current_step + tail
  end

  def solve(source_map)
    steps = next_search(source_map).each_with_object({}) do |(k, v), obj|
      obj[k] = v if /[a-z]/.match?(k)
    end
    steps_map = build_steps_map(source_map)
    required_keys = source_map.map { |line| line.select { |c| /[a-z]/.match?(c) } }.flatten.compact
    path = tail_path(required_keys, steps_map, steps, [])
    {
      steps_count: path.inject(0) { |acc, pt| acc + pt[1] },
      path: path
    }
  end

  def solve_bots(source_map)
    count = 0
    bot_steps = source_map.each_with_object({}).with_index do |(line, bots), y|
      line.each_with_index do |c, x|
        next if c != "@"
        one_bot_map = source_map.map.with_index do |l, yy|
          l.map.with_index do |cc, xx|
            cc == "@" && (xx != x || yy != y) ? "." : cc
          end
        end
        bots["@#{count}"] = next_search(one_bot_map)
        count += 1
      end
    end
    steps_map = build_steps_map(source_map)
    required_keys = source_map.map { |line| line.select { |c| /[a-z]/.match?(c) } }.flatten.compact
    bot_state = bot_steps.keys.each_with_object({}) { |bot, obj| obj[bot] = "0" }
    path = tail_path_bots(required_keys, steps_map, bot_steps, [], bot_state)
    {
      steps_count: path.inject(0) { |acc, pt| acc + pt[1] },
      path: path
    }
  end
end
