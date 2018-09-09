require 'rails_helper'

RSpec.describe SetsubiyoyakusController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/setsubiyoyakus').to route_to('setsubiyoyakus#index')
    end

    it 'routes to #new' do
      expect(get: '/setsubiyoyakus/new').to route_to('setsubiyoyakus#new')
    end

    it 'routes to #show' do
      expect(get: '/setsubiyoyakus/1').to route_to('setsubiyoyakus#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/setsubiyoyakus/1/edit').to route_to('setsubiyoyakus#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/setsubiyoyakus').to route_to('setsubiyoyakus#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/setsubiyoyakus/1').to route_to('setsubiyoyakus#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/setsubiyoyakus/1').to route_to('setsubiyoyakus#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/setsubiyoyakus/1').to route_to('setsubiyoyakus#destroy', id: '1')
    end
  end
end
