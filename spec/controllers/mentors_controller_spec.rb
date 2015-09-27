require 'rails_helper'

RSpec.describe MentorsController, type: :controller do
  let(:company) { create(:company) }
  let(:current_user) { create(:user, :admin, company: company) }

  before do
    sign_in current_user
  end

  describe 'GET index' do
    let!(:mentor) { create(:user, company: company) }

    it 'renders mentors' do
      get :index
      expect(assigns[:mentors]).to include(mentor)
      expect(assigns[:mentors]).to include(current_user)
    end
  end
end
