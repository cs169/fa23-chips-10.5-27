# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe '.find_all' do
    let(:category) { 'Candidate Loan' }
    let(:cycle) { '2022' }
    let(:stubbed_response) { { results: [{ 'name' => 'John Doe' }] }.to_json }

    before do
      stub_request(:get, "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/candidate-loan.json")
        .to_return(status: 200, body: stubbed_response, headers: {})
    end

    it 'makes and API request and returns candidate names' do
      result = described_class.find_all(cycle: cycle, category: category)
      expect(result).to include(include('name' => 'John Doe'))
    end
  end
end
