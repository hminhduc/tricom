require 'rails_helper'

RSpec.describe 'Events management', type: :request do
  let(:joutaimaster) { FactoryBot.create :joutaimaster }
  let(:shainmaster) { FactoryBot.create :shainmaster, :second }
  let(:valid_attributes) {
    {
      社員番号: shainmaster.社員番号,
      開始: '2018/08/01 09:00',
      終了: '2018/08/01 17:00',
      状態コード: joutaimaster.状態コード,
      comment: 'KSK冨田先生'
    }
  }
  let(:invalid_attributes) {
    {
      社員番号: shainmaster.社員番号,
      開始: '2018/08/01 17:01',
      終了: '2018/08/01 17:00',
      状態コード: joutaimaster.状態コード,
      comment: 'KSK冨田先生'
    }
  }
  let(:new_attributes) {
    {
      社員番号: shainmaster.社員番号,
      開始: '2018/08/01 17:01',
      終了: '2018/08/01 17:00',
      場所コード: joutaimaster.場所コード,
      comment: 'new comment'
    }
  }

  before do
    user = FactoryBot.create :user, password: 'abc123', admin: true
    post login_path, params: { session: { 担当者コード: user.id, password: 'abc123' } }
  end

  it 'get time line view' do
    get time_line_view_events_path
    expect(response).to render_template(:time_line_view)
    expect(response).to have_http_status(200)
  end

  it 'get a new event' do
    get new_event_path
    expect(response).to render_template(:new)
  end

  it 'get update event' do
    event = Event.create valid_attributes
    get edit_event_path(event)
    expect(response).to render_template(:edit)
  end

  describe 'create event' do
    context 'success' do
      it 'back to time line view' do
        post '/events', params: { event: valid_attributes, commit: I18n.t('helpers.submit.create'), param: 'timeline' }
        expect(response).to redirect_to('/events/time_line_view?locale=ja')
        follow_redirect!
        expect(response).to render_template(:time_line_view)
      end

      it 'back to calendar' do
        post '/events', params: { event: valid_attributes, commit: I18n.t('helpers.submit.create') }
        expect(response).to redirect_to('/events?locale=ja')
        follow_redirect!
        expect(response).to render_template(:index)
      end

      it 'sonnyuutouroku and back to time line view' do
        post '/events', params: { event: valid_attributes, commit: '挿入登録', param: 'timeline' }
        expect(response).to redirect_to('/events/time_line_view?locale=ja')
        follow_redirect!
        expect(response).to render_template(:time_line_view)
      end

      it 'sonnyuutouroku and back to calendar' do
        post '/events', params: { event: valid_attributes, commit: '挿入登録', param: 'event' }
        expect(response).to redirect_to('/events?locale=ja')
        follow_redirect!
        expect(response).to render_template(:index)
      end

      it 'use JS' do
        post '/events', params: { event: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to match /application\/json/
      end
    end

    context 'unsucccess' do
      it 'then render new' do
        post '/events', params: { event: invalid_attributes, commit: I18n.t('helpers.submit.create'), param: 'timeline' }
        expect(response).to render_template(:new)
      end

      it 'sonnyuutouroku and render new' do
        post '/events', params: { event: invalid_attributes, commit: '挿入登録', param: 'timeline' }
        expect(response).to render_template(:new)
      end

      it 'use JS' do
        post '/events', params: { event: invalid_attributes }
        expect(response).to have_http_status(422)
        expect(response.header['Content-Type']).to match /application\/json/
      end
    end
  end

  describe 'update event' do
    let(:event) { Event.create valid_attributes }
    context 'success' do
      it 'back to time line view' do
        put event_path(event), params: { event: valid_attributes, commit: I18n.t('helpers.submit.update'), param: 'timeline' }
        expect(response).to redirect_to('/events/time_line_view?locale=ja')
        follow_redirect!
        expect(response).to render_template(:time_line_view)
      end

      it 'back to calendar' do
        put event_path(event), params: { event: valid_attributes, commit: I18n.t('helpers.submit.update') }
        expect(response).to redirect_to('/events?locale=ja')
        follow_redirect!
        expect(response).to render_template(:index)
      end

      it 'create clone' do
        put event_path(event), params: { event: valid_attributes, commit: I18n.t('helpers.submit.create_clone') }
        expect(response).to redirect_to('/events?locale=ja')
        follow_redirect!
        expect(response).to render_template(:index)
      end

      it 'sonnyuutouroku and back to time line view' do
        put event_path(event), params: { event: valid_attributes, commit: '挿入登録', param: 'timeline' }
        expect(response).to redirect_to('/events/time_line_view?locale=ja')
        follow_redirect!
        expect(response).to render_template(:time_line_view)
      end

      it 'sonnyuutouroku and back to calendar' do
        put event_path(event), params: { event: valid_attributes, commit: '挿入登録', param: 'event' }
        expect(response).to redirect_to('/events?locale=ja')
        follow_redirect!
        expect(response).to render_template(:index)
      end
    end

    context 'unsucccess' do
      it 'then render edit' do
        put event_path(event), params: { event: invalid_attributes, commit: I18n.t('helpers.submit.update'), param: 'timeline' }
        expect(response).to render_template(:edit)
      end

      it 'sonnyuutouroku and render edit' do
        put event_path(event), params: { event: invalid_attributes, commit: '挿入登録', param: 'timeline' }
        expect(response).to render_template(:edit)
      end

      it 'create clone and render edit' do
        put event_path(event), params: { event: invalid_attributes, commit: I18n.t('helpers.submit.create_clone') }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'destroy' do
    it 'delete a event and redirect back to calendar' do
      event = Event.create valid_attributes
      delete event_path(event)
      expect(response).to redirect_to('/events?locale=ja')
    end

    it 'delete a event and redirect back to time line view' do
      event = Event.create valid_attributes
      delete event_path(event), params: { param: 'timeline' }
      expect(response).to redirect_to('/events/time_line_view?locale=ja')
    end
  end
end
