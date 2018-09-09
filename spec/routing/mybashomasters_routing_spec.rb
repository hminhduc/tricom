require 'rails_helper'

RSpec.describe MybashomastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/mybashomasters').to route_to('mybashomasters#index')
    end

    it 'routes to #new' do
      expect(get: '/mybashomasters/new').to route_to('mybashomasters#new')
    end

    it 'routes to #show' do
      expect(get: '/mybashomasters/1').to route_to('mybashomasters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/mybashomasters/1/edit').to route_to('mybashomasters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/mybashomasters').to route_to('mybashomasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/mybashomasters/1').to route_to('mybashomasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/mybashomasters/1').to route_to('mybashomasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/mybashomasters/1').to route_to('mybashomasters#destroy', id: '1')
    end
  end
end
