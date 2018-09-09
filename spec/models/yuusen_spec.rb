require 'rails_helper'

RSpec.describe Yuusen, type: :model do
  describe 'Associtations' do
    it do
      should have_many(:kairanyokenmsts)
      should have_many(:dengonyoukens)
    end
  end
end
