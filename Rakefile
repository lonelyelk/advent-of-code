# frozen_string_literal: true

require "date"

def year
  Date.today.strftime("%Y")
end

def template_args(args, next_day: false)
  t_args = { day: args.day.to_i, year: year }
  if t_args[:day].zero?
    t_args[:day] = Dir.children(year).map(&:to_i).max
    t_args[:day] += 1 if next_day
  end
  t_args
end

desc "Generate solution template for the day passed as single integer argument or for the next day"
task :next_day, [:day] do |_t, args|
  template_path = File.join(year, "template")
  spec_template_path = File.join("spec", year, "template")
  t_args = template_args(args, next_day: true)
  path = File.join(year, format("%<day>02d", t_args))
  spec_path = File.join("spec", year, format("%<day>02d", t_args))
  mkdir_p path
  mkdir_p spec_path
  %w[lib.rb run.rb].each do |name|
    File.open(File.join(path, name), "w") do |f|
      f.write format(File.read(File.join(template_path, "#{name}.txt")), t_args)
    end
  end
  File.open(File.join(spec_path, format("day%<day>02d_lib_spec.rb", t_args)), "w") do |f|
    f.write format(File.read(File.join(spec_template_path, "lib_spec.rb.txt")), t_args)
  end
end

desc "Run solution for the day passed as single integer argument or the last day"
task :run, [:day] do |_t, args|
  path = File.join(year, format("%<day>02d", template_args(args)), "run")
  require_relative path
end

task default: [:run]

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts "Failed to load rspec task"
end

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:rc)

  namespace :rc do
    desc "Short version of rc:auto_correct"
    task a: [:auto_correct]
  end
rescue LoadError
  puts "Failed to load rubocop task"
end
