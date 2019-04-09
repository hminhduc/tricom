begin
  puts "LOG CLEAR at #{Time.now.strftime('%Y/%m/%d %Hh %Mm %Ss')}"
  file = ENV['FILE'] || 'log/production.log'
  max_size = ENV['MAX_SIZE'].to_i || 1000000000
  if File.exist?(file) and File.size(file) > max_size
    FileUtils.cp(file, file + '.old')
    File.truncate(file, 0)
  end
rescue => e
  puts e
end
