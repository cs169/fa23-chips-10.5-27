# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :event do
    county
    start_time { 1.day.from_now }
    end_time { 2.days.from_now }
  end
end

RSpec.describe Event, type: :model do
  describe 'validations' do
    let(:event) { build(:event) }

    it 'validates start_time is not in the past' do
      event.start_time = 1.day.ago
      expect(event).not_to be_valid
      expect(event.errors[:start_time]).to include('must be after today')
    end

    it 'validates end_time is after start_time' do
      event.end_time = event.start_time - 1.hour
      expect(event).not_to be_valid
      expect(event.errors[:end_time]).to include('must be after start time')
    end
  end
end
