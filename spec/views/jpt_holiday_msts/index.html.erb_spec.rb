require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'jpt_holiday_msts/index.html.erb', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:jpt_holiday_mst) { FactoryBot.create :jpt_holiday_mst }
  it 'displays all the jpt_holiday_msts' do
    assign(:jpt_holiday_msts, [jpt_holiday_mst])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/jpt_holiday_msts'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/jpt_holiday_msts']")
  end
end
