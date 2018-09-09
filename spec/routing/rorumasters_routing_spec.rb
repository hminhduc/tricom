require 'rails_helper'

RSpec.describe RorumastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/rorumasters').to route_to('rorumasters#index')
    end

    it 'routes to #create' do
      expect(post: '/rorumasters').to route_to('rorumasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/rorumasters/1').to route_to('rorumasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/rorumasters/1').to route_to('rorumasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/rorumasters/1').to route_to('rorumasters#destroy', id: '1')
    end
  end
end
