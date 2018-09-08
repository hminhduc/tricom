require 'rails_helper'

RSpec.describe Bashomaster, type: :model do
  subject { FactoryBot.build :bashomaster }

  describe 'Associations' do
    it { should have_many(:events) }
    it { should have_many(:mybashomaster) }
    it { should belong_to(:kaishamaster) }
    it { should belong_to(:bashokubunmst) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    it 'is not valid without a 場所コード' do
      subject.場所コード = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a 場所名' do
      subject.場所名 = nil
      expect(subject).to_not be_valid
    end
    it 'is valid without a 場所名カナ' do
      subject.場所名カナ = nil
      expect(subject).to be_valid
    end
    it 'is valid without a SUB' do
      subject.SUB = nil
      expect(subject).to be_valid
    end
    it 'is valid without a 場所区分' do
      subject.場所区分 = nil
      expect(subject).to be_valid
    end
    it 'is valid with 場所区分!= 2 and without a 会社コード ' do
      subject.会社コード = nil
      expect(subject).to be_valid
    end
    it 'is not valid with 場所区分== 2 and without a 会社コード ' do
      subject.場所区分 = '2'
      subject.会社コード = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid with 会社コード not inclusion in Kaishamaster ' do
      subject.会社コード = 'test'
      expect(subject).to_not be_valid
    end
  end

  describe '#basho_kubun?' do
    let(:bashokubun) { FactoryBot.create :bashokubunmst, 場所区分コード: '2' }
    let(:basho) { FactoryBot.create :bashomaster, 場所区分: bashokubun.場所区分コード }
    it 'check 場所区分 is 2' do
      expect(subject.basho_kubun?).to eq(false)
      expect(basho.basho_kubun?).to eq(true)
    end
  end
end
