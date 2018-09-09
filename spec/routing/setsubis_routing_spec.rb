require 'rails_helper'

RSpec.describe SetsubisController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/setsubis').to route_to('setsubis#index')
    end

    it 'routes to #create' do
      expect(post: '/setsubis').to route_to('setsubis#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/setsubis/1').to route_to('setsubis#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/setsubis/1').to route_to('setsubis#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/setsubis/1').to route_to('setsubis#destroy', id: '1')
    end
  end
end
