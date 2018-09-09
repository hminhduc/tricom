require 'rails_helper'

RSpec.describe YuukyuuKyuukaRirekisController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/yuukyuu_kyuuka_rirekis').to route_to('yuukyuu_kyuuka_rirekis#index')
    end

    it 'routes to #new' do
      expect(get: '/yuukyuu_kyuuka_rirekis/new').to route_to('yuukyuu_kyuuka_rirekis#new')
    end

    it 'routes to #show' do
      expect(get: '/yuukyuu_kyuuka_rirekis/1').to route_to('yuukyuu_kyuuka_rirekis#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/yuukyuu_kyuuka_rirekis/1/edit').to route_to('yuukyuu_kyuuka_rirekis#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/yuukyuu_kyuuka_rirekis').to route_to('yuukyuu_kyuuka_rirekis#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/yuukyuu_kyuuka_rirekis/1').to route_to('yuukyuu_kyuuka_rirekis#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/yuukyuu_kyuuka_rirekis/1').to route_to('yuukyuu_kyuuka_rirekis#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/yuukyuu_kyuuka_rirekis/1').to route_to('yuukyuu_kyuuka_rirekis#destroy', id: '1')
    end
  end
end
