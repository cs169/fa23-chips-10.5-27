# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  dummy_result = OpenStruct.new(
    { offices:   [OpenStruct.new({ name:             'Title1',
                                   official_indices: [0] }),
                  OpenStruct.new({ name:             'Title1',
                                   official_indices: [1] })],
      officials: [OpenStruct.new({ name: 'John Doe' }),
                  OpenStruct.new({ name: 'John Doe' })] }
  )

  it "doesn't add duplicates" do
    described_class.civic_api_to_representative_params(dummy_result)
    expect(described_class.count).to eq(1)
  end

  it 'returns right reps' do
    expect(described_class.civic_api_to_representative_params(dummy_result).length).to eq(1)
  end
end
