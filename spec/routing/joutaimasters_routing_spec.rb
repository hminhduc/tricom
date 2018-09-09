require 'rails_helper'

RSpec.describe JoutaimastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/joutaimasters').to route_to('joutaimasters#index')
    end

    it 'routes to #new' do
      expect(get: '/joutaimasters/new').to route_to('joutaimasters#new')
    end

    it 'routes to #show' do
      expect(get: '/joutaimasters/1').to route_to('joutaimasters#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/joutaimasters/1/edit').to route_to('joutaimasters#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/joutaimasters').to route_to('joutaimasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/joutaimasters/1').to route_to('joutaimasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/joutaimasters/1').to route_to('joutaimasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/joutaimasters/1').to route_to('joutaimasters#destroy', id: '1')
    end
  end
end
