require 'rails_helper'

RSpec.describe JsonWebToken, type: :class do
  describe 'decode correct' do
    before { @token = JsonWebToken.encode(str: 'abc123') }
    it do
      expect(JsonWebToken.decode(@token)['str']).to eq 'abc123'
      expect(JsonWebToken.decode(@token)['exp']).to be_present
    end
  end

  describe 'decode incorrect' do
    before { @token = JsonWebToken.encode({ str: 'abc123' }, 1.minute.ago) }
    it { expect(JsonWebToken.decode(@token)).to eq nil }
  end
end
