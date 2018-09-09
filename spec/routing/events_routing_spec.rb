require 'rails_helper'

RSpec.describe EventsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/events').to route_to('events#index')
    end

    it 'routes to #time_line_view' do
      expect(get: '/events/time_line_view').to route_to('events#time_line_view')
    end

    it 'routes to #create' do
      expect(post: '/events').to route_to('events#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/events/1').to route_to('events#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/events/1').to route_to('events#update', id: '1')
    end
  end
end
