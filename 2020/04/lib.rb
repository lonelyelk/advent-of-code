REQUIRED = %w[byr iyr eyr hgt hcl ecl pid]
VALIDATION = {
  'byr' => (lambda do |value|
    md = value.match(/^\d{4}$/)
    md && md[0].to_i.between?(1920, 2002)
  end),
  'iyr' => (lambda do |value|
    md = value.match(/^\d{4}$/)
    md && md[0].to_i.between?(2010, 2020)
  end),
  'eyr' => (lambda do |value|
    md = value.match(/^\d{4}$/)
    md && md[0].to_i.between?(2020, 2030)
  end),
  'hgt' => (lambda do |value|
    md = value.match(/^(\d{2,3})(cm|in)$/)
    md && ((md[2] == 'cm' && md[1].to_i.between?(150, 193)) || (md[2] == 'in' && md[1].to_i.between?(59, 76)))
  end),
  'hcl' => (lambda do |value|
    /^#[0-9a-f]{6}$/.match?(value)
  end),
  'ecl' => (lambda do |value|
    %w[amb blu brn gry grn hzl oth].include?(value)
  end),
  'pid' => (lambda do |value|
    /^\d{9}$/.match?(value)
  end),
}

def valid_pass_count(input)
  passes = input.split("\n\n")
  passes.inject(0) do |cnt, pass|
    fields = pass.scan(/(\w{3}):\S+/).flatten
    cnt += 1 if REQUIRED.all? { |field| fields.include?(field) }
    cnt
  end
end

def valid_pass2_count(input)
  passes = input.split("\n\n")
  passes.inject(0) do |cnt, pass|
    fields = pass.scan(/(\w{3}):(\S+)/)
    valid = VALIDATION.inject(true) do |acc, (field, rule)|
      acc && fields.any? { |name, value| name == field && rule.call(value) }
    end
    cnt += 1 if valid
    cnt
  end
end
