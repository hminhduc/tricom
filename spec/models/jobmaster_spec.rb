require 'rails_helper'

RSpec.describe Jobmaster, type: :model do
  let(:jobmaster) { FactoryBot.create :jobmaster }
  describe 'doUpdateMyjob' do
    before do
      FactoryBot.create :myjobmaster, jobmaster: jobmaster
      jobmaster.update(job名: 'name123', 備考: 'note123')
    end
    it { expect(Myjobmaster.where(job名: 'name123').size).to eq 1 }
  end
end
