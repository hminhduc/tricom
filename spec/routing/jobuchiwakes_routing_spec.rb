require 'rails_helper'

RSpec.describe JobuchiwakesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/jobuchiwakes').to route_to('jobuchiwakes#index')
    end

    it 'routes to #create' do
      expect(post: '/jobuchiwakes').to route_to('jobuchiwakes#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/jobuchiwakes/1').to route_to('jobuchiwakes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/jobuchiwakes/1').to route_to('jobuchiwakes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/jobuchiwakes/1').to route_to('jobuchiwakes#destroy', id: '1')
    end
  end
end
