require 'rails_helper'

RSpec.describe DashboardsController do
  describe 'GET show' do
    before do
      sign_in current_user
    end

    context 'created company' do
      let(:mentee) { current_user.mentees.first }
      let(:current_user) { create(:user, :mentor_with_mentee, company: create(:company)) }

      context 'when there is answered check point' do
        let!(:answered_check_point) { create(:check_point, :answered, :started, mentee: mentee) }

        it 'renders dashboard template' do
          get :show
          is_expected.to render_template(:show)

          expect(assigns[:answered_check_points]).to eq [answered_check_point]
          expect(assigns[:unanswered_check_points]).to eq []
        end
      end

      context 'when there is unanswered check point' do
        let!(:unanswered_check_point) { create(:check_point, :started, mentee: mentee) }

        it 'renders dashboard template' do
          get :show
          is_expected.to render_template(:show)

          expect(assigns[:answered_check_points]).to eq []
          expect(assigns[:unanswered_check_points]).to eq [unanswered_check_point]
        end
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
