require 'rails_helper'

RSpec.describe BashomastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/bashomasters').to route_to('bashomasters#index')
    end

    it 'routes to #new' do
      expect(get: '/bashomasters/new').to route_to('bashomasters#new')
    end

    it 'routes to #show' do
      expect(get: '/bashomasters/1').to route_to('bashomasters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/bashomasters/1/edit').to route_to('bashomasters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/bashomasters').to route_to('bashomasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/bashomasters/1').to route_to('bashomasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/bashomasters/1').to route_to('bashomasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/bashomasters/1').to route_to('bashomasters#destroy', id: '1')
    end
  end
end
