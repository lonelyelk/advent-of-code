def fix_report(report)
  report.each_with_index do |num, i|
    report[(i+1)..-1].each do |num1|
      return num * num1 if num + num1 == 2020
    end
  end
  raise "Not found"
end

def fix_report3(report)
  report.each_with_index do |num, i|
    report[(i+1)..-1].each_with_index do |num1, j|
      report[(i+j+1)..-1].each do |num2|
        return num * num1 * num2 if num + num1 +num2 == 2020
      end
    end
  end
  raise "Not found"
end
