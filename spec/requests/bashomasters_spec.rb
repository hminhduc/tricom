require 'rails_helper'

RSpec.describe 'Bashomasters management', type: :request do
  let(:kaishamaster) { FactoryBot.create :kaishamaster }
  let(:valid_attributes) {
    {
      場所コード: 1122334455,
      場所名: 'test 場所名',
      場所名カナ: 'test 場所名カナ',
      SUB: 'test',
      場所区分: '1',
      会社コード: kaishamaster.会社コード
    }
  }
  let(:invalid_attributes) {
    {
      場所コード: 1122334455,
      場所名: nil,
      場所名カナ: 'test 場所名カナ',
      SUB: 'test',
      場所区分: '1',
      会社コード: kaishamaster.会社コード
    }
  }
  let(:new_attributes) {
    {
      場所コード: 1122334455,
      場所名: 'test 場所名 updated',
      場所名カナ: 'test 場所名カナ updated',
      SUB: 'test updated',
      場所区分: '2',
      会社コード: kaishamaster.会社コード
    }
  }

  before do
    user = FactoryBot.create :user, password: 'abc123', admin: true
    post login_path, params: { session: { 担当者コード: user.id, password: 'abc123' } }
  end

  it 'list all Bashomasters!' do
    get bashomasters_path
    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
  end

  it 'creates a Bashomaster and redirects to the Bashomaster page' do
    get new_bashomaster_path
    expect(response).to render_template(:new)
    post '/bashomasters', params: { bashomaster: valid_attributes }
    expect(response).to redirect_to('/bashomasters?locale=ja')
    follow_redirect!
    expect(response).to render_template(:index)
  end

  it 'does not render a different template' do
    get '/bashomasters/new'
    expect(response).to_not render_template(:show)
  end

  it 'updates a Bashomaster and redirects to the Bashomaster page' do
    bashomaster = Bashomaster.create valid_attributes
    get edit_bashomaster_path(bashomaster)
    expect(response).to render_template(:edit)
    put bashomaster_path(bashomaster), params: { bashomaster: new_attributes }
    expect(response).to redirect_to('/bashomasters?locale=ja')
    follow_redirect!
    expect(response).to render_template(:index)
  end

  it 'deletes a Bashomaster and redirects to the bashomasters list' do
    bashomaster = Bashomaster.create valid_attributes
    delete bashomaster_path(bashomaster), headers: { 'ACCEPT' => 'application/javascript' }
    expect(response).to render_template('share/destroy')
  end
end
