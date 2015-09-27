require 'rails_helper'

RSpec.describe DashboardsController do
  describe 'GET show' do
    before do
      sign_in current_user
    end

    context 'created company' do
      let(:current_user) { create(:user, company: create(:company)) }

      let(:answered_check_points) { [] }
      let(:unanswered_check_points) { [] }
      let(:presenter) { instance_double('Dashboard::ShowDashboard',
                                        answered_check_points: answered_check_points,
                                        unanswered_check_points: unanswered_check_points) }

      it 'renders dashboard' do
        expect(Dashboard::ShowDashboard).to receive(:new)
          .with(current_user).and_return(presenter)
        get :show
        expect(assigns[:presenter]).to eq presenter
      end
    end

    context 'company has not been created' do
      let(:current_user) { create(:user, company: nil) }

      it 'redirects to company create page' do
        get :show
        is_expected.to redirect_to(new_company_path)
      end
    end
  end
end
