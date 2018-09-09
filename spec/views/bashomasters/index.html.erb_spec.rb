require 'rails_helper'
include ApplicationHelper

RSpec.describe 'bashomasters/index.html.erb', type: :view do
  it 'displays all the bashomasters' do
    assign(:bashomasters, [
      (FactoryBot.create :bashomaster, 場所名: 'abc'),
      (FactoryBot.create :bashomaster, :second, 場所名: 'def')
    ])
    render
    response.body.should match(/abc/)
    response.body.should match(/def/)
  end
end
