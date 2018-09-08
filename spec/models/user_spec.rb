require 'rails_helper'

RSpec.describe User, type: :model do
  # thiết lập cho biến user nhận giá trị này:
  let(:user) { FactoryBot.build :user, email: 'kamejoko' }

  describe 'has wrong_format_email' do
    it 'with email_errors' do
      expect(user).to be_invalid
      # mong đợi một trong các nguyên nhân làm user đó không hợp lệ là do email ko đúng định dạng:
      expect(user.errors[:email].join('')).to eq(I18n.t('errors.messages.wrong_mail_form'))
    end

    it 'with no email_errors' do
      user.email = 'nguyendinhhung@gmail.com'
      user.password = '12'
      expect(user).not_to be_valid
      # mong đợi là sau khi thay đổi email đúng format, lỗi sẽ ko còn chứa email nữa:
      expect(user.errors[:email].join('')).to eq('')
    end
  end
end
