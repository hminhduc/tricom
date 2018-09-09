require 'rails_helper'

RSpec.describe YakushokumastersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/yakushokumasters').to route_to('yakushokumasters#index')
    end

    it 'routes to #create' do
      expect(post: '/yakushokumasters').to route_to('yakushokumasters#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/yakushokumasters/1').to route_to('yakushokumasters#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/yakushokumasters/1').to route_to('yakushokumasters#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/yakushokumasters/1').to route_to('yakushokumasters#destroy', id: '1')
    end
  end
end
