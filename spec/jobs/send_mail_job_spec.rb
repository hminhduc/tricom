require 'rails_helper'

RSpec.describe SendMailJob, type: :job do
  describe 'decode correct' do
    before do
      @to = 'hungnd.k58@gmail.com'
      @from = 'from'
      @subject = 'subject'
      @body = 'body'
    end
    it do
      # expect { SendMailJob.perform_later(@to, @from, @subject, @body) }
      #       .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
