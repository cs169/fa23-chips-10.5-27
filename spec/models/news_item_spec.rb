# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  
  describe '.issues' do
    it 'returns an array type' do
      expect(described_class.issues).to be_an_instance_of(Array)
    end

    it 'returns nonempty array' do
      expect(described_class.issues).not_to be_empty
    end
  end

end
