namespace :tricom do
  desc 'Reset mat khau cua user'
  task resetpassword: :environment do
    puts "RESET PASSWORD at #{Time.now.strftime('%Y/%m/%d %Hh %Mm %Ss')} ..."
    new_password = BCrypt::Password.create(ENV['PASS'] || '123456', cost: 10)
    User.find_by_id(ENV['USER'])
        .try(:update, password_digest: new_password)
  end
end
