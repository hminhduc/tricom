require 'rails_helper'

RSpec.describe BashokubunmstsController, type: :controller do
  let!(:bashokubunmst) { FactoryBot.create :bashokubunmst }
  let(:valid_attributes) {
    { 場所区分コード: '123', 場所区分名: 'bashokubunmst name' }
  }

  let(:invalid_attributes) {
    { 場所区分コード: '123' }
  }

  let(:valid_session) { { current_user_id: FactoryBot.create(:user).id } }

  describe 'GET #index' do
    it 'assigns all bashokubunmsts as @bashokubunmsts' do
      get :index, session: valid_session
      expect(assigns(:bashokubunmsts)).to eq(Bashokubunmst.all)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:post_valid) { post :create, xhr: true, params: { bashokubunmst: valid_attributes }, session: valid_session }
      it 'creates a new Bashokubunmst' do
        expect { post_valid }.to change(Bashokubunmst, :count).by(1)
      end

      it 'assigns a newly created bashokubunmst as @bashokubunmst' do
        post_valid
        expect(assigns(:bashokubunmst)).to be_a(Bashokubunmst)
        expect(assigns(:bashokubunmst)).to be_persisted
      end

      it 'redirects to the created bashokubunmst' do
        post_valid
        expect(response).to render_template('share/create')
      end
    end

    context 'with invalid params' do
      let(:post_invalid) { post :create, xhr: true, params: { bashokubunmst: invalid_attributes }, session: valid_session }
      it 'assigns a newly created but unsaved bashokubunmst as @bashokubunmst' do
        post_invalid
        expect(assigns(:bashokubunmst)).to be_a_new(Bashokubunmst)
      end

      it 're-renders the new template' do
        post_invalid
        expect(response).to render_template('share/create')
      end
    end
  end

  describe 'PUT #update' do
    before { @bashokubunmst = FactoryBot.create :bashokubunmst, 場所区分コード: '123', 場所区分名: '0000' }
    context 'with valid params' do
      let(:new_attributes) { { 場所区分コード: '123', 場所区分名: '5678' } }
      before { put :update, xhr: true, params: { id: @bashokubunmst.to_param, bashokubunmst: new_attributes }, session: valid_session }
      it 'updates the requested bashokubunmst' do
        @bashokubunmst.reload
        expect(@bashokubunmst.場所区分名).to eq('5678')
      end

      it 'assigns the requested bashokubunmst as @bashokubunmst' do
        @bashokubunmst.reload
        expect(assigns(:bashokubunmst)).to eq(@bashokubunmst)
      end

      it 'redirects to the bashokubunmst' do
        expect(response).to render_template('share/update')
      end
    end

    context 'with invalid params' do
      before { put :update, xhr: true, params: { id: @bashokubunmst.to_param, bashokubunmst: invalid_attributes }, session: valid_session }
      it 'assigns the bashokubunmst as @bashokubunmst' do
        expect(assigns(:bashokubunmst)).to eq(@bashokubunmst)
      end

      it 're-renders the edit template' do
        expect(response).to render_template('share/update')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested bashokubunmst' do
      expect {
        delete :destroy, xhr: true, params: { id: bashokubunmst.to_param }, session: valid_session
      }.to change(Bashokubunmst, :count).by(-1)
    end

    it 'redirects to the bashokubunmsts list' do
      delete :destroy, xhr: true, params: { id: bashokubunmst.to_param }, session: valid_session
      expect(response).to render_template('share/destroy')
    end
  end
end
