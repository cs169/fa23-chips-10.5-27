# frozen_string_literal: true

class CampaignsController < ApplicationController
  def index
    @cycle = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
    @category = {
      'Candidate Loan'      =>	'candidate-loan',
      'Contribution Total'  =>	'contribution-total',
      'Debts Owed'          =>	'debts-owed',
      'Disbursements Total' =>	'disbursements-total',
      'End Cash'            =>	'end-cash',
      'Individual Total'    =>	'individual-total',
      'PAC Total'           =>	'pac-total',
      'Receipts Total'      =>	'receipts-total',
      'Refund Total'        =>	'refund-total'
    }.keys
  end

  def search
    @campaigns = Campaign.find_all(params[:campaign])
  end
end
