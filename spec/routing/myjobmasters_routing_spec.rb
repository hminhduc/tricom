require 'rails_helper'

RSpec.describe MyjobmastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/myjobmasters').to route_to('myjobmasters#index')
    end

    it 'routes to #new' do
      expect(get: '/myjobmasters/new').to route_to('myjobmasters#new')
    end

    it 'routes to #show' do
      expect(get: '/myjobmasters/1').to route_to('myjobmasters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/myjobmasters/1/edit').to route_to('myjobmasters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/myjobmasters').to route_to('myjobmasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/myjobmasters/1').to route_to('myjobmasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/myjobmasters/1').to route_to('myjobmasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/myjobmasters/1').to route_to('myjobmasters#destroy', id: '1')
    end
  end
end
