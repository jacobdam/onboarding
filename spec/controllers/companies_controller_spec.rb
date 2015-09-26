require 'rails_helper'

RSpec.describe CompaniesController do
  let!(:current_user) { create(:user, :admin, company: nil) }

  before do
    sign_in current_user
  end

  describe 'GET new' do
    before do
      get :new
    end

    context 'when user does not belong to any company' do
      it 'assign @check_points' do
        expect(assigns(:company)).to be_a_new(Company)
      end

      it { is_expected.to render_template(:new) }
    end

    context 'when user belongs to a company already' do
      let!(:current_user) { create(:user, :admin, company: create(:company) ) }

      it { is_expected.to redirect_to(dashboard_path) }
    end
  end

  describe 'POST create' do
    before do
      post :create, company: params
    end

    context 'when user belongs to a company already' do
      let(:params) { { name: '' } }
      let!(:current_user) { create(:user, :admin, company: create(:company) ) }

      it { is_expected.to redirect_to(dashboard_path) }
    end

    context 'invalid params' do
      let(:params) { { name: '' } }
    
      it 'does not create company' do
        expect(current_user.reload.company).to be_nil
      end

      it 'assigns @company' do
        expect(assigns(:company)).to be_a_new(Company)
      end

      it { is_expected.to render_template(:new) }
    end

    context 'valid params' do
      let(:params) { attributes_for(:company) }

      it 'creates Company' do
        expect(current_user.reload.company).to_not be_nil
      end

      it { is_expected.to redirect_to(dashboard_path) }
    end
  end

  describe 'GET edit' do
    let!(:current_user) { create(:user, :admin, company: create(:company)) }

    before do
      get :edit
    end

    it 'assign @company' do
      expect(assigns(:company)).to eq(current_user.company)
    end

    it { is_expected.to render_template(:edit) }

  end

  describe 'PATCH update' do
    let!(:current_user) { create(:user, :admin, company: create(:company)) }

    context 'valid params' do
      let(:params) { attributes_for(:company, name: 'Company A') }
      before do
        patch :update, company: params
      end

      it 'updates Company' do
        expect(current_user.company.reload.name).to eq('Company A')
      end

      it 'redirects to dashboard' do
        is_expected.to redirect_to(dashboard_path)
      end
    end

    context 'invalid params' do
      let(:params) { { name: '' } }

      before do
        patch :update, company: params
      end

      it 'does not update company' do
        expect(current_user.company.reload.name).to_not be_blank
      end

      it 'assigns @company' do
        expect(assigns(:company)).to eq(current_user.company)
      end

      it 'render :edit template' do
        is_expected.to render_template(:edit)
      end
    end
  end
end
