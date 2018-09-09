require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { FactoryBot.build :task }
  let(:invalid_task) { FactoryBot.build :task, title: nil }

  describe 'valid' do
    it { expect(task).to be_valid }
  end

  describe 'invalid' do
    it { expect(invalid_task).to be_invalid }
  end
end
