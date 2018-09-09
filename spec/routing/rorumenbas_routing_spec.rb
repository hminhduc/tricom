require 'rails_helper'

RSpec.describe RorumenbasController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/rorumenbas').to route_to('rorumenbas#index')
    end

    it 'routes to #new' do
      expect(get: '/rorumenbas/new').to route_to('rorumenbas#new')
    end

    it 'routes to #show' do
      expect(get: '/rorumenbas/1').to route_to('rorumenbas#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/rorumenbas/1/edit').to route_to('rorumenbas#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/rorumenbas').to route_to('rorumenbas#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/rorumenbas/1').to route_to('rorumenbas#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/rorumenbas/1').to route_to('rorumenbas#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/rorumenbas/1').to route_to('rorumenbas#destroy', id: '1')
    end
  end
end
