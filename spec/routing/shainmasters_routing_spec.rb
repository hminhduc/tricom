require 'rails_helper'

RSpec.describe ShainmastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/shainmasters').to route_to('shainmasters#index')
    end

    it 'routes to #new' do
      expect(get: '/shainmasters/new').to route_to('shainmasters#new')
    end

    it 'routes to #show' do
      expect(get: '/shainmasters/1').to route_to('shainmasters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/shainmasters/1/edit').to route_to('shainmasters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/shainmasters').to route_to('shainmasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/shainmasters/1').to route_to('shainmasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/shainmasters/1').to route_to('shainmasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/shainmasters/1').to route_to('shainmasters#destroy', id: '1')
    end
  end
end
