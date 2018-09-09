require 'rails_helper'

RSpec.describe SagyoukubunsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/sagyoukubuns').to route_to('sagyoukubuns#index')
    end

    it 'routes to #create' do
      expect(post: '/sagyoukubuns').to route_to('sagyoukubuns#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/sagyoukubuns/1').to route_to('sagyoukubuns#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/sagyoukubuns/1').to route_to('sagyoukubuns#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/sagyoukubuns/1').to route_to('sagyoukubuns#destroy', id: '1')
    end
  end
end
