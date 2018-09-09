require 'rails_helper'

RSpec.describe ShozokumastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/shozokumasters').to route_to('shozokumasters#index')
    end

    it 'routes to #create' do
      expect(post: '/shozokumasters').to route_to('shozokumasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/shozokumasters/1').to route_to('shozokumasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/shozokumasters/1').to route_to('shozokumasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/shozokumasters/1').to route_to('shozokumasters#destroy', id: '1')
    end
  end
end
