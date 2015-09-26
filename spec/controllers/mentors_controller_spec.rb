require 'rails_helper'

RSpec.describe MentorsController, type: :controller do
  let(:company) { create(:company) }
  let(:current_user) { create(:user, :admin, company: company) }
  before do
    sign_in current_user
  end
end
