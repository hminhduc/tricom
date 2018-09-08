require 'rails_helper'

RSpec.describe Kintai, type: :model do
  let(:kintai) { FactoryBot.build :kintai }

  it { expect(kintai).to be_valid }

  describe 'invalid' do
    context 'joutaimaster missing' do
      before do
        @kintai = kintai
        @kintai.状態1 = '123456'
      end
      it do
        expect(@kintai).to be_invalid
        expect(@kintai.errors['状態1']).not_to eq nil
      end
    end
  end

  describe 'update' do
    before do
      joutaimaster1 = FactoryBot.create :joutaimaster, 状態コード: '111', 状態区分: '1'
      joutaimaster2 = FactoryBot.create :joutaimaster, 状態コード: '222', 状態区分: '2'
      @kintai = FactoryBot.create :kintai, 状態1: joutaimaster1.状態コード, 勤務タイプ: '001'
      @kintai.update(状態1: joutaimaster2.状態コード)
    end
    it { expect(@kintai.reload.勤務タイプ).to eq '' }
  end
end
