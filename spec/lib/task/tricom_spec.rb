require 'rails_helper'
require 'rake'

RSpec.describe Rake::Task, type: :task do
  describe 'Reset mat khau cua user' do
    before do
      @user = FactoryBot.create :user
      ENV['USER'] = @user.id
      Rake::Task['tricom:resetpassword'].reenable
    end
    it { expect(@user.authenticate('999999999')).not_to eq(false) }

    context 'with default password' do
      before do
        Rake::Task['tricom:resetpassword'].invoke
      end
      it { expect(@user.reload.authenticate('123456')).not_to eq(false) }
    end

    context 'with custom password' do
      before do
        ENV['PASS'] = 'abc123'
        Rake::Task['tricom:resetpassword'].invoke
      end
      it { expect(@user.reload.authenticate('abc123')).not_to eq(false) }
    end
  end
end
