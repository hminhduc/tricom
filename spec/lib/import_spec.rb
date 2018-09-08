require 'rails_helper'
include Import

RSpec.describe Import, type: :lib do
  describe 'import normal' do
    it 'use string table_name then success' do
      puts import_from_csv('Eki', File.open('spec/lib/import.csv'), %w(駅コード 駅名 駅名カナ), %w(駅コード))
      expect(Eki.count).to eq 6
    end

    it 'use class table_name then success' do
      puts import_from_csv(Eki, File.open('spec/lib/import.csv'))
      expect(Eki.count).to eq 6
    end
  end

  describe 'import fail' do
    context 'with wrong table name' do
      before { @result = import_from_csv(123, File.open('spec/lib/import.csv')) }
      it do
        expect(Eki.count).to eq 0
        expect(@result).to eq 'テーブル名が見つかりません'
      end
    end

    context 'with invalid primary key' do
      before { @result = import_from_csv('Eki', File.open('spec/lib/import.csv'), %w(駅コード 駅名 駅名カナ), %w(駅コード2)) }
      it do
        expect(Eki.count).to eq 0
        expect(@result).to match(/行\d+( キー: ).+(必要)/)
      end
    end

    context 'with missing columns' do
      before do
        @file = CSV.open('temp.csv', 'w') do |csv|
          csv << %w(駅コード 駅名)
          csv << %w(01323 大阪)
        end
        @result = import_from_csv('Eki', @file, %w(駅コード 駅名 駅名カナ))
      end
      it do
        expect(Eki.count).to eq 0
        expect(@result).to match(/行\d+( カラム: ).+(必要)/)
      end
      after do
        FileUtils.rm(@file.path)
      end
    end

    context 'with not existed file' do
      before do
        @result = import_from_csv('CaoSieu', File.open('spec/lib/import.csv'))
      end
      it { expect(@result).to eq 'uninitialized constant CaoSieu' }
    end

    context 'with existed object' do
      before do
        FactoryBot.create :eki
        @file = CSV.open('temp.csv', 'w') do |csv|
          csv << %w(駅コード 駅名 駅名カナ)
          csv << %w(01323)
        end
        @result = import_from_csv('Eki', @file, %w(駅コード 駅名 駅名カナ), %w(駅コード))
      end
      it do
        expect(Eki.count).to eq 1
        expect(@result).to match(/行\d .+(、)?.+/)
      end
      after do
        FileUtils.rm(@file.path)
      end
    end
  end
end
