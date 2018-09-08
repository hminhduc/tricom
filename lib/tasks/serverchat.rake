namespace :serverchat do
  desc 'Start server chat'
  task start: :environment do
    exec 'RAILS_ENV=production rackup private_pub.ru -s thin -E production -D'
  end
end
