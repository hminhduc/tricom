require 'rails_helper'
include ApplicationHelper

RSpec.describe 'bashomasters/index.html.erb', type: :view do
  let(:bashomaster) { FactoryBot.create :bashomaster }
  it 'displays all the bashomasters' do
    assign(:bashomasters, [bashomaster])
    render
    expect(response).to have_text(bashomaster.場所コード)
    expect(response).to have_text(bashomaster.場所名)
    expect(response).to have_selector("a.glyphicon.glyphicon-edit.remove-underline[href*='/edit']")
    expect(response).to have_selector("a.glyphicon.glyphicon-remove.text-danger.remove-underline[href^='/bashomasters']")
  end
end
