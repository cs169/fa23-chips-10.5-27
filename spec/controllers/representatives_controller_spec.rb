# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  let!(:representative) do
    Representative.create!(name: 'John Doe')
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'responds successfully with 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index page' do
      expect(response).to render_template(:index)
    end

    it 'loads all reps into @representatives' do
      expect(assigns(:representatives)).to match_array(representative)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: representative.id }
    end

    it 'responds successfully with 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show page' do
      expect(response).to render_template('show')
    end

    it 'loads reps into @representative' do
      expect(assigns(:representative)).to eq(representative)
    end

    it 'raises a RecordNotFound error' do
      expect do
        get :show, params: { id: 99 }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
