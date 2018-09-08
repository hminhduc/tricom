require 'rails_helper'

RSpec.describe YuukyuuKyuukaRireki, type: :model do
  let(:ykkk) { FactoryBot.create :yuukyuu_kyuuka_rireki }
  let(:next_ykkk) { FactoryBot.create :yuukyuu_kyuuka_rireki, :next_month }

  it { expect(next_ykkk.月初有給残).not_to eq ykkk.月末有給残 }

  describe 'update_getshozan_of_next_month' do
    before do
      @delta = next_ykkk.月初有給残 - next_ykkk.月末有給残
      ykkk.update_getshozan_of_next_month
      next_ykkk.reload
    end
    it do
      expect(next_ykkk.月初有給残).to eq ykkk.月末有給残
      expect(next_ykkk.月初有給残 - next_ykkk.月末有給残).to eq @delta
    end
  end

  describe 'calculate_getshozan' do
    before do
      @ykkk = FactoryBot.create :yuukyuu_kyuuka_rireki, 月初有給残: nil
      @before_ykkk = FactoryBot.create :yuukyuu_kyuuka_rireki, :before_month
      @ykkk.calculate_getshozan
    end
    it { expect(@ykkk.月初有給残).to eq @before_ykkk.月末有給残 }
  end

  describe 'calculate_getmatsuzan' do
    before do
      joutaimaster1 = FactoryBot.create :joutaimaster, 状態コード: '31'
      joutaimaster2 = FactoryBot.create :joutaimaster, 状態コード: '30'
      joutaimaster3 = FactoryBot.create :joutaimaster, 状態コード: '32'
      FactoryBot.create :kintai, 日付: '2018-09-01'.to_date, 状態1: joutaimaster1.状態コード
      FactoryBot.create :kintai, 日付: '2018-09-30'.to_date, 状態1: joutaimaster2.状態コード
      FactoryBot.create :kintai, 日付: '2018-09-10'.to_date, 状態1: joutaimaster3.状態コード
      @ykkk = FactoryBot.create :yuukyuu_kyuuka_rireki, 月初有給残: 11.0
      puts @ykkk.社員番号, Kintai.pluck(:社員番号)
      @ykkk.calculate_getmatsuzan
    end
    it { expect(@ykkk.月末有給残).to eq 9.0 }
  end
end
