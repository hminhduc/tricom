require 'rails_helper'

RSpec.describe Conversation, type: :model do
  before do
    @sender = FactoryBot.create :user
    @recipient = FactoryBot.create :user, :second
    FactoryBot.create :conversation, sender_id: @sender.id, recipient_id: @recipient.id
  end

  describe 'involving' do
    it { expect(Conversation.involving(@sender).size).to eq 1 }
  end

  describe 'between' do
    it { expect(Conversation.between(@sender, @recipient).size).to eq 1 }
  end
end
