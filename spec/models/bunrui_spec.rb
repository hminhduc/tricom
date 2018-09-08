require 'rails_helper'

RSpec.describe Bunrui, type: :model do
  let(:bunrui) { FactoryBot.create :bunrui }

  subject { bunrui }

  it { should respond_to(:分類コード) } # thay thế cho đoạn code trên ta có thể sử dụng dòng lệnh sau
  it { should respond_to(:分類名) }
  it { should respond_to(:jobmaster) } # has_one :jobmaster, foreign_key: :分類コード, dependent: :nullify

  it { should be_valid } # kiểm tra xem biến có tồn tại hay không

  describe 'when 分類コード is not present' do # kiểm tra nếu 分類コード rỗng biến có tồn tại hay không, tương đương với dòng presence: true trong model
    before { bunrui.分類コード = ' ' }
    it { should_not be_valid }
  end

  describe 'when 分類名 is not presend' do # kiểm tra nếu 分類名 rỗng biến có tồn tại hay không, tương đương với dòng presence: true trong model
    before { bunrui.分類名 = ' ' }
    it { should_not be_valid }
  end

  describe 'when 分類コード is duplication' do # kiểm tra nếu 分類名 rỗng biến có tồn tại hay không, tương đương với dòng validates :分類コード, uniqueness: true trong model
    it { expect(bunrui.dup).to be_invalid }
  end

  describe 'to_csv' do
    before { bunrui }
    it { expect(Bunrui.to_csv()).to eq "分類コード,分類名\n01,AA\n" }
  end
end
