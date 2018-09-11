require 'rails_helper'
include ApplicationHelper
include SessionsHelper

RSpec.describe 'yuukyuu_kyuuka_rirekis/index.html.haml', type: :view do
  let(:admin_user) { FactoryBot.create :user, :admin, :second }
  let(:yuukyuu_kyuuka_rireki) { FactoryBot.create :yuukyuu_kyuuka_rireki }
  it 'displays all the yuukyuu_kyuuka_rirekis' do
    assign(:yuukyuu_kyuuka_rirekis, [yuukyuu_kyuuka_rireki])
    assign(:current_user, admin_user)
    render
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href^='/yuukyuu_kyuuka_rirekis'][href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/yuukyuu_kyuuka_rirekis']")
  end
end
