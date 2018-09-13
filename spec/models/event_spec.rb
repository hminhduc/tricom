require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.create :event, 開始: '2000-1-1 01:00', 終了: '2000-1-1 03:00' }
  let(:event1) { FactoryBot.create :event, 開始: '2000-1-1 03:00', 終了: '2000-1-1 05:00' }
  let(:event2) { FactoryBot.create :event, 開始: '2000-1-1 05:00', 終了: '2000-1-1 07:00' }
  let(:event3) { FactoryBot.create :event, 開始: '2000-1-1 07:00', 終了: '2000-1-1 09:00' }

  it { expect(event).to be_persisted }

  describe 'sounyuutouroku' do
    context 'new event trung duoi event khac' do
      let(:event4) { FactoryBot.build :event, 開始: '2000-1-1 04:00', 終了: '2000-1-1 06:00' }
      before do
        event1
        event4.sounyuutouroku
      end
      it do
        expect(Event.count).to eq 2
        expect(event1.reload.終了).to eq '2000-1-1 04:00'
        expect(event4).to be_persisted
      end
    end

    context 'new event trung dau event khac' do
      let(:event4) { FactoryBot.build :event, 開始: '2000-1-1 02:00', 終了: '2000-1-1 04:00' }
      before do
        event1
        event4.sounyuutouroku
      end
      it do
        expect(Event.count).to eq 2
        expect(event1.reload.開始).to eq '2000-1-1 04:00'
        expect(event4).to be_persisted
      end
    end

    context 'new event bao trum event khac' do
      let(:event4) { FactoryBot.build :event, 開始: '2000-1-1 02:00', 終了: '2000-1-1 06:00' }
      before do
        event1
        event4.sounyuutouroku
      end
      it do
        expect(Event.count).to eq 1
        expect(Event.find_by_id(event1.id)).to eq nil
        expect(event4).to be_persisted
      end
    end

    context 'new event la con event khac' do
      let(:event4) { FactoryBot.build :event, 開始: '2000-1-1 03:30', 終了: '2000-1-1 04:30' }
      before do
        event1
        event4.sounyuutouroku
      end
      it do
        expect(event1.reload.終了).to eq '2000-1-1 03:30'
        expect(Event.count).to eq 3
        expect(Event.find_by(開始: '2000-1-1 04:30', 終了: '2000-1-1 05:00')).not_to eq nil
        expect(event4).to be_persisted
      end
    end
  end

  describe 'update mybasho after event save' do
    let!(:event) { FactoryBot.create :event }
    context 'create' do
      it { expect(Mybashomaster.find_by(社員番号: event.社員番号, 場所コード: event.場所コード)).not_to eq nil }
    end
    context 'update' do
      let(:bashomaster) { FactoryBot.create :bashomaster, :second }
      before { event.update(場所コード: bashomaster.場所コード) }
      it { expect(Mybashomaster.find_by(社員番号: event.社員番号, 場所コード: bashomaster.場所コード)).not_to eq nil }
    end
  end

  describe 'update myjob after event save' do
    let!(:event) { FactoryBot.create :event }
    context 'create' do
      it { expect(Myjobmaster.find_by(社員番号: event.社員番号, job番号: event.JOB)).not_to eq nil }
    end
    context 'update' do
      let(:jobmaster) { FactoryBot.create :jobmaster, :second }
      before { event.update(JOB: jobmaster.job番号) }
      it { expect(Myjobmaster.find_by(社員番号: event.社員番号, job番号: jobmaster.job番号)).not_to eq nil }
    end
  end
end
