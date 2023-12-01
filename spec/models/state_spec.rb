# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { 'Example State' }
  end
end

RSpec.describe State, type: :model do
  describe '#std_fips_code' do
    it 'returns the fips code standardized to two digits' do
      single_digit_fips = described_class.new(fips_code: 6)
      double_digit_fips = described_class.new(fips_code: 12)

      expect(single_digit_fips.std_fips_code).to eq '06'
      expect(double_digit_fips.std_fips_code).to eq '12'
    end
  end
end
