require 'rails_helper'

RSpec.describe Tsushinseigyou, type: :model do
  describe 'Associtations' do
    it { should belong_to(:shainmaster) }
  end
end
