# frozen_string_literal: true

require "net/http"
require "cgi"
require "date"

def year
  Date.today.strftime("%Y")
end

def template_args(args, next_day: false)
  t_args = { day: args.day.to_i, year: }
  if t_args[:day].zero?
    t_args[:day] = Dir.children(year).map(&:to_i).max || 0
    t_args[:day] += 1 if next_day
  end
  t_args
end

def session
  File.read(".session").chomp
end

desc "Generate solution template for the day passed as single integer argument or for the next day"
task :next_day, [:day] do |_t, args|
  template_path = File.join("template")
  t_args = template_args(args, next_day: true)
  path = File.join(year, format("%<day>02d", t_args))
  spec_path = File.join("spec", year, format("%<day>02d", t_args))
  mkdir_p path
  mkdir_p spec_path
  %w[lib.rb run.rb].each do |name|
    File.write(File.join(path, name), format(File.read(File.join(template_path, "#{name}.txt")), t_args))
  end
  File.write(File.join(spec_path, format("day%<day>02d_lib_spec.rb", t_args)),
             format(File.read(File.join(template_path, "lib_spec.rb.txt")), t_args))
  uri = URI(format("https://adventofcode.com/%<year>s/day/%<day>d/input", t_args))
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
    request = Net::HTTP::Get.new(uri)
    session_cookie = CGI::Cookie.new("session", session)
    request["Cookie"] = session_cookie.to_s
    response = http.request(request)
    File.write(File.join(path, "input.txt"), response.body)
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
    task a: [:autocorrect_all]
  end
rescue LoadError
  puts "Failed to load rubocop task"
end
