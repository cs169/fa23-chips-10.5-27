# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :county do
    state
  end
end

RSpec.describe County, type: :model do
  describe '#std_fips_code' do
    let(:county) { build(:county, fips_code: fips_code) }

    context 'when fips_code is a single digit' do
      let(:fips_code) { 1 }

      it 'returns a 3-character string with leading zeros' do
        expect(county.std_fips_code).to eq('001')
      end
    end

    context 'when fips_code is two digits' do
      let(:fips_code) { 12 }

      it 'returns a 3-character string with a leading zero' do
        expect(county.std_fips_code).to eq('012')
      end
    end

    context 'when fips_code is three digits' do
      let(:fips_code) { 123 }

      it 'returns the fips_code as a string' do
        expect(county.std_fips_code).to eq('123')
      end
    end
  end
end
