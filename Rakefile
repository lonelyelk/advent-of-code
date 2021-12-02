# frozen_string_literal: true

desc "Generate solution template for the day passed as single integer argument or for the next day"
task :next_day, [:day] do |_t, args|
  year = "2021"
  template_path = File.join(year, "template")
  spec_template_path = File.join("spec", year, "template")
  template_args = { day: args.day.to_i }
  template_args[:day] = Dir.children(year).map(&:to_i).max + 1 if template_args[:day].zero?
  path = File.join(year, format("%<day>02d", template_args))
  spec_path = File.join("spec", year, format("%<day>02d", template_args))
  mkdir_p path
  mkdir_p spec_path
  %w[lib.rb run.rb].each do |name|
    File.open(File.join(path, name), "w") do |f|
      f.write format(File.read(File.join(template_path, "#{name}.txt")), template_args)
    end
  end
  File.open(File.join(spec_path, format("day%<day>02d_lib_spec.rb", template_args)), "w") do |f|
    f.write format(File.read(File.join(spec_template_path, "lib_spec.rb.txt")), template_args)
  end
end

desc "Run solution for the day passed as single integer argument or the last day"
task :run, [:day] do |_t, args|
  year = "2021"
  template_args = { day: args.day.to_i }
  template_args[:day] = Dir.children(year).map(&:to_i).max if template_args[:day].zero?
  path = File.join(year, format("%<day>02d", template_args), "run")
  require_relative path
end

task default: [:run]
