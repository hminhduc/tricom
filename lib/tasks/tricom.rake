namespace :tricom do
  desc 'Reset mat khau cua user'
  task resetpassword: :environment do
    new_password = BCrypt::Password.create(ENV['PASS'] || '123456', cost: 10)
    User.find_by_id(ENV['USER'])
        .try(:update, password_digest: new_password)
  end

  desc 'Xoa du lieu cu hon 3 thang'
  task remove_old_data: :environment do
    begin
      shain_ids = Setting.where(turning_data: true).pluck(:社員番号)
      Kintai.where('日付 < ?', 3.month.ago).where(社員番号: shain_ids).destroy_all
      Event.where('DATE(終了) < ?', 3.month.ago).where(社員番号: shain_ids).destroy_all
    rescue => e
      puts e
    end
  end
end
