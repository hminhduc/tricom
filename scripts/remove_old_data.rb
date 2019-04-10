begin
  puts "REMOVE OLD DATA at #{Time.now.strftime('%Y/%m/%d %Hh %Mm %Ss')}"
  shain_ids = Setting.where(turning_data: true).pluck(:社員番号)
  Kintai.where('日付 < ?', 3.month.ago).where(社員番号: shain_ids).destroy_all
  Event.where('DATE(終了) < ?', 3.month.ago).where(社員番号: shain_ids).destroy_all
rescue => e
  puts e
end
