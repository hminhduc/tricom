require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'has wrong_format_email' do
    let(:user) { FactoryBot.build :user, email: 'kamejoko' }
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

  describe 'validate user' do
    let(:user) { FactoryBot.build :user, password: 'abc123' }
    before { user.save }
    context 'user existed' do
      let(:new_user) { FactoryBot.build :user, 担当者コード: user.担当者コード }
      it do
        expect(new_user).to be_invalid
        expect(new_user.errors['担当者コード'].join('')).to match /#{I18n.t('errors.messages.taken')}/
      end
    end

    context 'user with no shainmaster' do
      let(:new_user) { FactoryBot.build :user, 担当者コード: 'abcdef' }
      it do
        expect(new_user).to be_invalid
        expect(new_user.errors['担当者コード'].join('')).to match /#{I18n.t('errors.messages.invalid')}/
      end
    end

    context 'user with empty code' do
      let(:new_user) { FactoryBot.build :user, 担当者コード: '' }
      it do
        expect(new_user).to be_invalid
        expect(new_user.errors['担当者コード'].join('')).to match //
      end
    end
  end

  describe 'create user' do
    let(:user) { FactoryBot.create :user, password: 'abc123' }
    context 'password is correct after save' do
      it do
        expect(user.authenticate('------')).to eq false
        expect(user.authenticate('abc123')).to eq user
      end
    end
  end

  describe 'update user' do
    let(:user) { FactoryBot.create :user, password: 'abc123' }
    context 'password is incorrect then no save' do
      before { user.update(担当者名称: 'new name') }
      it do
        expect(user.reload.担当者名称).not_to eq 'new name'
        expect(user.errors['current_password'].join('')).to match /#{I18n.t('errors.messages.current_password_incorrect')}/
      end
    end

    context 'password is correct then save' do
      before do
        user.current_password = 'abc123'
        user.update(担当者名称: 'new name')
      end
      it do
        expect(user.reload.担当者名称).to eq 'new name'
      end
    end
  end

  describe 'import from csv' do
    let(:shainmaster) { FactoryBot.create :shainmaster }
    let(:file) do
      CSV.open('temp.csv', 'w') do |csv|
        csv << User::CSV_HEADERS
        csv << [shainmaster.社員番号, 'name', true, 'abc@gmail.com', true]
      end
    end
    it { expect { User.import(file) }.to change { User.count }.by(1) }
    after { FileUtils.remove(file.path) }
  end
end
