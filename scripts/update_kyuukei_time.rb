begin
  puts "UPDATE KYUUKEI TIME at #{Time.now.strftime('%Y/%m/%d %Hh %Mm %Ss')}"
  Kintaiteeburu.all.each do |o|
    print [o.夜休憩時間, o.深夜休憩時間, o.早朝休憩時間, o.実労働時間], "\n"
    o.実労働時間 += (o.夜休憩時間 + o.深夜休憩時間 + o.早朝休憩時間)
    o.夜休憩時間 = o.深夜休憩時間 = o.早朝休憩時間 = 0
    o.save
  end
rescue => e
  puts e
end
