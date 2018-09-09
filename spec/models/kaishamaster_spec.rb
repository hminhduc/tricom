require 'rails_helper'

RSpec.describe Kaishamaster, type: :model do
  let(:kaishamaster) { FactoryBot.create :kaishamaster }
  describe 'doUpdateMykaisha' do
    before do
      FactoryBot.create :mykaishamaster, kaishamaster: kaishamaster
      kaishamaster.update(会社名: 'name123', 備考: 'note123')
    end
    it { expect(Mykaishamaster.where(会社名: 'name123').size).to eq 1 }
  end
end
