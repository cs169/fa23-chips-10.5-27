# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  before do
    @california = State.create!({
                                  name:         'California',
                                  symbol:       'CA',
                                  fips_code:    '06',
                                  is_territory: false,
                                  lat_min:      0.0,
                                  lat_max:      1.0,
                                  long_min:     0.0,
                                  long_max:     1.0
                                })

    get :index
  end

  describe 'GET index' do
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns all states to @states' do
      expect(assigns(:states)).to eq(State.all)
    end

    it 'indexes states by FIPS code in @states_by_fips_code' do
      expected_hash = { '06' => @california }
      expect(assigns(:states_by_fips_code)).to eq(expected_hash)
    end
  end

  describe 'GET state' do
    context 'with a valid state' do
      before { get :state, params: { 'state_symbol' => 'CA' } }

      it 'renders the state template' do
        expect(response).to render_template(:state)
      end

      it 'assigns the correct state to @state' do
        expect(assigns(:state)).to eq(@california)
      end
    end

    context 'with an invalid state' do
      before { get :state, params: { 'state_symbol' => 'INVALID' } }

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
