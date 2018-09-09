require 'rails_helper'

RSpec.describe Setsubiyoyaku, type: :model do
  let!(:setsubiyoyaku) { FactoryBot.create :setsubiyoyaku }
  let(:setsubiyoyaku1) { FactoryBot.build :setsubiyoyaku, :invalid_time }
  let(:setsubiyoyaku2) { FactoryBot.build :setsubiyoyaku, :same_time }

  it do
    should belong_to(:setsubi)
    should belong_to(:shainmaster)
    should belong_to(:kaishamaster)
  end

  describe 'valid' do
    it { expect(setsubiyoyaku).to be_persisted }
  end

  describe 'invalid' do
    context 'start time > end time' do
      it do
        expect(setsubiyoyaku1).to be_invalid
        expect(setsubiyoyaku1.errors['終了']).to be_any
      end
    end

    context 'conflict time when new' do
      it 'when new' do
        expect(setsubiyoyaku2).to be_invalid
        expect(setsubiyoyaku2.errors['設備コード']).to be_any
      end
    end

    context 'conflict time when update' do
      before do
        @setsubiyoyaku = FactoryBot.create :setsubiyoyaku, :second
        @setsubiyoyaku.開始 = setsubiyoyaku2.開始
      end
      it do
        expect(@setsubiyoyaku).to be_invalid
        expect(@setsubiyoyaku.errors['設備コード']).to be_any
      end
    end
  end
end
