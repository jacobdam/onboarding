require 'rails_helper'

RSpec.describe DashboardsController do
  describe 'GET show' do
    before do
      sign_in current_user
      get :show
    end

    context 'created company' do
      let(:current_user) { create(:user, company: create(:company)) }

      it 'renders dashboard template' do
        is_expected.to render_template(:show)
      end
    end

    context 'company has not been created' do
      let(:current_user) { create(:user, company: nil) }

      it 'redirects to company create page' do
        is_expected.to redirect_to(new_company_path)
      end
    end
  end
end
