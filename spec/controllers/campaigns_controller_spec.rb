# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'responds successfully with 200' do
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index page' do
      expect(response).to render_template(:index)
    end

    it 'assigns cycle and category' do
      expect(assigns(:cycle)).to eq([2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020])
      expect(assigns(:category)).to eq(['Candidate Loan', 'Contribution Total', 'Debts Owed', 'Disbursements Total',
                                        'End Cash', 'Individual Total', 'PAC Total', 'Receipts Total', 'Refund Total'])
    end
  end

  describe 'GET #search' do
    let(:campaign_params) { { 'cycle' => '2020', 'category' => 'Candidate Loan' } }
    let(:mock_campaigns) { ['Campaign 1', 'Campaign 2'] }

    before do
      allow(Campaign).to receive(:find_all).and_return(mock_campaigns)
      get :search, params: { campaign: campaign_params }
    end

    it 'calls find_all with parameters' do
      expect(Campaign).to have_received(:find_all).with(hash_including(campaign_params))
    end

    it 'assigns campaigns' do
      expect(assigns(:campaigns)).to eq(mock_campaigns)
    end

    it 'renders the search page' do
      expect(response).to render_template(:search)
    end
  end
end
