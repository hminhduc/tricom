require 'rails_helper'

RSpec.describe YuusensController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/yuusens').to route_to('yuusens#index')
    end

    it 'routes to #new' do
      expect(get: '/yuusens/new').to route_to('yuusens#new')
    end

    it 'routes to #show' do
      expect(get: '/yuusens/1').to route_to('yuusens#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/yuusens/1/edit').to route_to('yuusens#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/yuusens').to route_to('yuusens#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/yuusens/1').to route_to('yuusens#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/yuusens/1').to route_to('yuusens#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/yuusens/1').to route_to('yuusens#destroy', id: '1')
    end
  end
end
