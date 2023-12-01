# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  let!(:representative) do
    Representative.create!(name: 'John Doe')
  end
  let(:news_item) { create(:news_item, representative: representative) }
  let(:valid_attributes) do
    {
      news:              'Some news content',
      title:             'News Title',
      description:       'Detailed description of the news item',
      link:              'http://example.com/news',
      representative_id: representative.id
    }
  end
  let(:invalid_attributes) do
    {
      news:              '',
      title:             '',
      description:       '',
      link:              'not-a-valid-url',
      representative_id: nil
    }
  end

  describe 'POST #create' do
    it 'creates a new news item and redirects' do
      post :create, params: { representative_id: representative.id, news_item: valid_attributes }
      expect(NewsItem.count).to eq(0)
    end

    it 'does not create new news item' do
      post :create, params: { representative_id: representative.id, news_item: invalid_attributes }
      expect(NewsItem.count).to eq(0)
    end
  end
end
