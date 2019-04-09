namespace :tricom do
  desc 'Reset mat khau cua user'
  task resetpassword: :environment do
    new_password = BCrypt::Password.create(ENV['PASS'] || '123456', cost: 10)
    User.find_by_id(ENV['USER'])
        .try(:update, password_digest: new_password)
    exec "echo 'RESET PASSWORD at #{Time.now.strftime("%Y/%m/%d %Hh %Mm %Ss")} ...'"
  end

  desc 'Xoa du lieu cu hon 3 thang'
  task remove_old_data: :environment do
    begin
      shain_ids = Setting.where(turning_data: true).pluck(:社員番号)
      Kintai.where('日付 < ?', 3.month.ago).where(社員番号: shain_ids).destroy_all
      Event.where('DATE(終了) < ?', 3.month.ago).where(社員番号: shain_ids).destroy_all
      exec "echo 'REMOVE OLD DATA at #{Time.now.strftime("%Y/%m/%d %Hh %Mm %Ss")} ...'"
    rescue => e
      puts e
    end
  end

  desc 'Xoa log cu trong production.log'
  task log_clear: :environment do
    begin
      file = ENV['FILE'] || 'log/production.log'
      max_size = ENV['MAX_SIZE'].to_i || 1000000000
      if File.exist?(file) and File.size(file) > max_size
        FileUtils.cp(file, file + '.old')
        File.truncate(file, 0)
      end
      exec "echo 'LOG CLEAR at #{Time.now.strftime("%Y/%m/%d %Hh %Mm %Ss")} ...'"
    rescue => e
      puts e
    end
  end
end
