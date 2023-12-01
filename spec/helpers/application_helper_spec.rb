# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '.state_ids_by_name' do
    before do
      State.create(
        name:         'State1',
        id:           1,
        symbol:       :s1,
        fips_code:    'F1',
        is_territory: false,
        lat_min:      0.0,
        lat_max:      1.0,
        long_min:     0.0,
        long_max:     1.0
      )
      State.create(
        name:         'State2',
        id:           2,
        symbol:       :s2,
        fips_code:    'F2',
        is_territory: false,
        lat_min:      0.0,
        lat_max:      1.0,
        long_min:     0.0,
        long_max:     1.0
      )
    end

    it 'returns a hash of states mapped to ids' do
      expected_result = {
        'State1' => 1,
        'State2' => 2
      }

      expect(described_class.state_ids_by_name).to eq(expected_result)
    end
  end

  describe '.state_symbols_by_name' do
    before do
      State.create(
        name:         'State1',
        symbol:       :s1,
        fips_code:    'F1',
        is_territory: false,
        lat_min:      0.0,
        lat_max:      1.0,
        long_min:     0.0,
        long_max:     1.0
      )
      State.create(
        name:         'State2',
        symbol:       :s2,
        fips_code:    'F2',
        is_territory: false,
        lat_min:      0.0,
        lat_max:      1.0,
        long_min:     0.0,
        long_max:     1.0
      )
    end

    it 'returns a hash of states mapped to symbols' do
      expected_result = {
        'State1' => 's1',
        'State2' => 's2'
      }

      expect(described_class.state_symbols_by_name).to eq(expected_result)
    end
  end

  describe '.nav_items' do
    it 'returns an array of navigation items' do
      nav_items = described_class.nav_items

      expect(nav_items).to be_a(Array)
      expect(nav_items.first).to have_key(:title)
      expect(nav_items.first).to have_key(:link)
    end
  end

  describe '.active' do
    it 'returns the active class if the current controller matches the navigation link' do
      allow(Rails.application.routes).to receive(:recognize_path).and_return({ controller: 'home' })

      expect(described_class.active('home', '/')).to eq('bg-primary-active')
    end

    it 'returns an empty string if the current controller does not match the navigation link' do
      allow(Rails.application.routes).to receive(:recognize_path).and_return({ controller: 'events' })

      expect(described_class.active('home', '/events')).to eq('')
    end
  end
end
