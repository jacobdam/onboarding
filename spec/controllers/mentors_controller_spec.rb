require 'rails_helper'

RSpec.describe MentorsController, type: :controller do

  describe "GET #new:get" do
    it "returns http success" do
      get :new:get
      expect(response).to have_http_status(:success)
    end
  end

end
