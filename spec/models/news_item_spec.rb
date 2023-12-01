# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :news_item do
    representative
    title { 'test' }
    link { 'test' }
    description { 'test' }
  end
end

RSpec.describe NewsItem, type: :model do

  describe '.issues' do
    it 'returns an array type' do
      expect(described_class.issues).to be_an_instance_of(Array)
    end

    it 'returns nonempty array' do
      expect(described_class.issues).not_to be_empty
    end
  end

  describe '.find_for' do
    let(:representative) { create(:representative) }
    let!(:news_item) { create(:news_item, representative: representative) }

    it 'returns the correct news item for a representative' do
      puts "Representative ID: #{representative.id}"
      puts "All NewsItems: #{described_class.where(representative_id: representative.id).to_a}"

      expect(described_class.find_for(representative.id)).to eq(news_item)
    end
  end
end
