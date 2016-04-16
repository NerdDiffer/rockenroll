require 'rails_helper'

describe FeedbackController do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/contact').to route_to('feedback#new')
    end

    it 'routes to #create' do
      expect(post: '/contact').to route_to('feedback#create')
    end
  end
end
