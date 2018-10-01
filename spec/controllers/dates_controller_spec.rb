require 'rails_helper'

RSpec.describe DatesController, type: :controller do
  login_user

  describe 'GET #update' do
    it 'Returns HTTP success' do
      get :update, params: { date: '09-30-2018' }
      expect(response).to have_http_status(:redirect)
      expect(session[:current_date]).to eq('09-30-2018')
    end
  end
end