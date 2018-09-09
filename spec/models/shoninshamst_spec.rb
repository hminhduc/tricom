require 'rails_helper'

RSpec.describe Shoninshamst, type: :model do
  let(:shoninshamst) { FactoryBot.build :shoninshamst }
  let(:invalid_shoninshamst) { FactoryBot.build :shoninshamst, :same_shain }

  describe 'valid' do
    it { expect(shoninshamst).to be_valid }
  end

  describe 'invalid' do
    it { expect(invalid_shoninshamst).to be_invalid }
  end
end
