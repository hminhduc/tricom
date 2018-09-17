require 'rails_helper'

RSpec.describe EventsHelper, type: :helper do
  describe 'time_calculate' do
    context 'no kinmu_type' do
      let(:result) { time_calculate('2001-1-1 07:00', '2001-1-1 16:00') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 0
        expect(result[:hiru_kyukei]).to eq 60
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 480
        expect(result[:fustu_zangyo]).to eq 0
        expect(result[:shinya_zangyou]).to eq 0
      end
    end

    context 'with kinmu_type' do
      let(:result) { time_calculate('2001-1-1 07:00', '2001-1-1 16:00', '002') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 0
        expect(result[:hiru_kyukei]).to eq 60
        expect(result[:soutai]).to eq 30
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 450
        expect(result[:fustu_zangyo]).to eq 0
        expect(result[:shinya_zangyou]).to eq 0
      end
    end

    context 'with start_time <= kinmu_start < kinmu_end <= end_time' do
      let(:result) { time_calculate('2001-1-1 07:00', '2001-1-1 18:00', '002') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 0
        expect(result[:hiru_kyukei]).to eq 60
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 480
        expect(result[:fustu_zangyo]).to eq 90
        expect(result[:shinya_zangyou]).to eq 0
      end
    end

    context 'with kinmu_start >= end_time' do
      let(:result) { time_calculate('2001-1-1 07:00', '2001-1-1 14:00', '011') }
      it { expect(result).to eq Hash.new }
    end

    context 'with start_time >= kinmu_end' do
      let(:result) { time_calculate('2001-1-1 16:30', '2001-1-1 18:00', '001') }
      it { expect(result).to eq Hash.new }
    end

    context 'with kinmu_start < start_time < kinmu_end <= end_time' do
      let(:result) { time_calculate('2001-1-1 07:30', '2001-1-1 16:30', '001') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 30
        expect(result[:hiru_kyukei]).to eq 60
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 450
        expect(result[:fustu_zangyo]).to eq 0
        expect(result[:shinya_zangyou]).to eq 0
      end
    end

    context 'with kinmu_start < start_time < kinmu_end <= end_time' do
      let(:result) { time_calculate('2001-1-1 07:30', '2001-1-1 16:30', '001') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 30
        expect(result[:hiru_kyukei]).to eq 60
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 450
        expect(result[:fustu_zangyo]).to eq 0
        expect(result[:shinya_zangyou]).to eq 0
      end
    end

    context 'when shinya_zangyou # 0' do
      let(:result) { time_calculate('2001-1-1 20:00', '2001-1-2 02:00') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 0
        expect(result[:hiru_kyukei]).to eq 0
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 60
        expect(result[:real_hours]).to eq 0
        expect(result[:fustu_zangyo]).to eq 180
        expect(result[:shinya_zangyou]).to eq 120
      end
    end

    context 'when yoru_kyukei # 0' do
      let(:result) { time_calculate('2001-1-1 17:00', '2001-1-1 20:00') }
      it do
        expect(result[:souchou_kyukei]).to eq 0
        expect(result[:chikoku]).to eq 0
        expect(result[:hiru_kyukei]).to eq 0
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 60
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 0
        expect(result[:fustu_zangyo]).to eq 120
        expect(result[:shinya_zangyou]).to eq 0
      end
    end

    context 'when souchou_kyukei # 0' do
      let(:result) { time_calculate('2001-1-1 05:00', '2001-1-1 08:00') }
      it do
        expect(result[:souchou_kyukei]).to eq 120
        expect(result[:chikoku]).to eq 0
        expect(result[:hiru_kyukei]).to eq 0
        expect(result[:soutai]).to eq 0
        expect(result[:yoru_kyukei]).to eq 0
        expect(result[:shinya_kyukei]).to eq 0
        expect(result[:real_hours]).to eq 60
        expect(result[:fustu_zangyo]).to eq 0
        expect(result[:shinya_zangyou]).to eq 0
      end
    end
  end

  describe 'caculate_koushuu' do
    it { expect(caculate_koushuu('2001-1-1 07:00', '2001-1-2 02:00')).to eq 16.0 }
  end

  describe 'time_calculate with events' do
    let(:event1) { FactoryBot.build :event, 開始: '2001/01/01 07:00', 終了: '2018/01/01 09:00' }
    let(:event2) { FactoryBot.build :event, 開始: '2001/01/01 10:00', 終了: '2018/01/01 21:00' }
    let(:result) { time_calculate('2001-1-1 07:00', '2001-1-1 22:00', '001', [event1, event2]) }
    it do
      expect(result[:souchou_kyukei]).to eq 0
      expect(result[:chikoku]).to eq 0
      expect(result[:hiru_kyukei]).to eq 60
      expect(result[:soutai]).to eq 0
      expect(result[:yoru_kyukei]).to eq 60
      expect(result[:shinya_kyukei]).to eq 0
      expect(result[:real_hours]).to eq 480
      expect(result[:fustu_zangyo]).to eq 300
      expect(result[:shinya_zangyou]).to eq 0
    end
  end
end
