require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe "GET #support" do
    it "returns http redirect" do
      get :support
      expect(response).to have_http_status(:redirect)
    end
  end

end
