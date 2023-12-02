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
      officials: [OpenStruct.new({ name:      'John Doe',
                                   party:     'Republican',
                                   photo_url: 'http://example.com/john_doe.jpg',
                                   address:   [OpenStruct.new(line1: '123 Example St',
                                                              line2: 'Apt 106',
                                                              city:  'Berkeley',
                                                              state: 'CA',
                                                              zip:   '94704')] }),
                  OpenStruct.new({ name:      'John Doe2',
                                   party:     'Democrat',
                                   photo_url: 'http://example.com/john_smith.jpg',
                                   address:   [OpenStruct.new(line1: '321 Random St',
                                                              city:  'Los Angeles',
                                                              state: 'CA',
                                                              zip:   '91800')] })] }
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

  it 'returns right reps' do
    expect(described_class.civic_api_to_representative_params(dummy_result).length).to eq(2)
  end

  describe '.extract_full_address' do
    context 'when address is present' do
      let(:address) { dummy_result.officials.first.address }

      it 'returns a formatted address' do
        expect(described_class.extract_full_address(address)).to eq('123 Example St, Apt 106, Berkeley, CA, 94704')
      end
    end

    context 'when address is nil' do
      it 'returns nil' do
        expect(described_class.extract_full_address(nil)).to be_nil
      end
    end
  end
end
