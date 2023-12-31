# frozen_string_literal: true

require 'faraday'

class Campaign < ApplicationRecord
  CATEGORIES = {
    'Candidate Loan'      =>	'candidate-loan',
    'Contribution Total'  =>	'contribution-total',
    'Debts Owed'          =>	'debts-owed',
    'Disbursements Total' =>	'disbursements-total',
    'End Cash'            =>	'end-cash',
    'Individual Total'    =>	'individual-total',
    'PAC Total'           =>	'pac-total',
    'Receipts Total'      =>	'receipts-total',
    'Refund Total'        =>	'refund-total'
  }.freeze

  def self.find_all(prm)
    base_url = 'https://api.propublica.org/campaign-finance/v1/'
    api_key = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
    request = Faraday.get(
      "#{base_url}#{prm[:cycle]}/candidates/leaders/#{CATEGORIES[prm[:category]]}.json", nil, 'X-API-Key' => api_key
    )
    response = JSON.parse(request.body)
    response['results']
  end
end
