require 'rails_helper'

RSpec.describe Shainmaster, type: :model do
  subject { FactoryBot.build :shainmaster }

  describe 'Associations' do
    it do
      %i(events kairan kairanshosai kintais mybashomaster myjobmaster send_dengons receive_dengons).each do |x|
        should have_many(x)
      end
      %i(user keihihead setting).each do |x|
        should have_one(x)
      end
      %i(shozai shozokumaster yakushokumaster rorumaster).each do |x|
        should belong_to(x)
      end
    end
  end

  describe 'Strip code' do
    before { @shain = FactoryBot.create :shainmaster, :unstrip }
    it { expect(@shain.id).to eq 'abc 123' }
  end
end
