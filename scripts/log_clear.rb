begin
  puts "LOG CLEAR at #{Time.now.strftime('%Y/%m/%d %Hh %Mm %Ss')}"
  max_size = 100000000
  ['log/production.log', 'log/development/log'].each do |file|
    if File.exist?(file) and File.size(file) > max_size
      FileUtils.cp(file, file + '.old')
      File.truncate(file, 0)
    end
  end
rescue => e
  puts e
end
