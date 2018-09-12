require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'kintais/sumikakunin.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:kintai) { FactoryBot.create :kintai }
  let(:job) { FactoryBot.create :jobmaster }
  it 'displays all the bunruis' do
    assign(:kintais, [kintai])
    assign(:current_user, admin_user)
    assign(:date, DateTime.now)
    assign(:jobs, [job])
    render
    expect(response).to have_selector("#search_job[type='text']")
    expect(response).to have_selector('#search')
  end
end
