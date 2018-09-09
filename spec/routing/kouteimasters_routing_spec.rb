require 'rails_helper'

RSpec.describe KouteimastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/kouteimasters').to route_to('kouteimasters#index')
    end

    it 'routes to #create' do
      expect(post: '/kouteimasters').to route_to('kouteimasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/kouteimasters/1').to route_to('kouteimasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/kouteimasters/1').to route_to('kouteimasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/kouteimasters/1').to route_to('kouteimasters#destroy', id: '1')
    end
  end
end
