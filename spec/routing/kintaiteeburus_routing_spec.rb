require 'rails_helper'

RSpec.describe KintaiteeburusController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/kintaiteeburus').to route_to('kintaiteeburus#index')
    end

    it 'routes to #new' do
      expect(get: '/kintaiteeburus/new').to route_to('kintaiteeburus#new')
    end

    it 'routes to #show' do
      expect(get: '/kintaiteeburus/1').to route_to('kintaiteeburus#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/kintaiteeburus/1/edit').to route_to('kintaiteeburus#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/kintaiteeburus').to route_to('kintaiteeburus#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/kintaiteeburus/1').to route_to('kintaiteeburus#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/kintaiteeburus/1').to route_to('kintaiteeburus#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/kintaiteeburus/1').to route_to('kintaiteeburus#destroy', id: '1')
    end
  end
end
