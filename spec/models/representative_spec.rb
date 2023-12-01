# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :representative do
    name { 'John Doe' }
  end
end

RSpec.describe Representative, type: :model do
  dummy_result = OpenStruct.new(
    { offices:   [OpenStruct.new({ name:             'Title1',
                                   official_indices: [0] }),
                  OpenStruct.new({ name:             'Title2',
                                   official_indices: [1] })],
      officials: [OpenStruct.new({ name: 'John Doe', title: 'Title1' }),
                  OpenStruct.new({ name: 'John Doe2', title: 'Title2' })] }
  )

  it "doesn't add duplicates" do
    described_class.create(name: 'John Doe', title: 'Title1')
    described_class.create(name: 'John Doe2', title: 'Title2')
    expect { described_class.civic_api_to_representative_params(dummy_result) }.not_to change(described_class, :count)
  end

  it 'adds new people' do
    described_class.create(name: 'John Doe3', title: 'Title3')
    expect { described_class.civic_api_to_representative_params(dummy_result) }.to change(described_class, :count).by(2)
  end
end
