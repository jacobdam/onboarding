require 'rails_helper'

RSpec.describe CheckPointsController do
  let!(:company) { create(:company) }
  let!(:mentee) { create(:mentee, company: company, check_points: build_list(:check_point, 2)) }
  let!(:check_point) { mentee.check_points.first }
  let!(:current_user) { create(:user, :admin, company: company) }

  before do
    sign_in current_user
  end

  describe 'GET index' do
    before do
      get :index, mentee_id: mentee.id
    end

    it 'assign @check_points' do
      expect(assigns(:check_points)).to match_array(mentee.check_points)
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'DELETE destroy' do
    before do
      delete :destroy, mentee_id: mentee.id, id: check_point.id
    end

    it 'destroys check_point' do
      expect(CheckPoint.exists?(id: check_point.id)).to eq(false)
    end

    it 'redirects to :index' do
      is_expected.to redirect_to(mentee_check_points_path)
    end
  end

  describe 'GET new' do
    before do
      get :new, mentee_id: mentee.id, id: check_point.id
    end

    it 'assign @check_point' do
      expect(assigns(:check_point)).to be_a_new(CheckPoint)
    end

    it { is_expected.to render_template(:new) }
  end

  describe 'POST create' do
    context 'valid params' do
      let(:params) { attributes_for(:check_point, question_attributes: attributes_for(:question)) }

      it 'creates CheckPoint' do
        expect {
          post :create, mentee_id: mentee.id, check_point: params
        }.to change { mentee.check_points.count }.by(1)
      end

      it 'redirects to :index' do
        post :create, mentee_id: mentee.id, check_point: params

        is_expected.to redirect_to(mentee_check_points_path)
      end
    end

    context 'invalid params' do
      let(:params) { { start_date: '' } }

      it 'does not create check_point' do
        expect {
          post :create, mentee_id: mentee.id, check_point: params
        }.to_not change { mentee.check_points.count }
      end

      it 'assigns @check_point' do
        post :create, mentee_id: mentee.id, check_point: params
        expect(assigns(:check_point)).to be_a_new(CheckPoint)
      end

      it 'render :new template' do
        post :create, mentee_id: mentee.id, check_point: params
        is_expected.to render_template(:new)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, mentee_id: mentee.id, id: check_point.id
    end

    it 'assign @check_point' do
      expect(assigns(:check_point)).to eq(check_point)
    end

    it { is_expected.to render_template(:edit) }
  end

  describe 'PATCH update' do
    context 'valid params' do
      let(:params) { attributes_for(:check_point, question_attributes: attributes_for(:question, name: 'Question A')) }
      before do
        patch :update, mentee_id: mentee.id, id: check_point.id, check_point: params
      end

      it 'updates CheckPoint' do
        expect(check_point.reload.question.name).to eq('Question A')
      end

      it 'redirects to' do
        is_expected.to redirect_to(mentee_check_points_path)
      end
    end

    context 'invalid params' do
      let(:params) { { start_date: nil } }

      before do
        patch :update, mentee_id: mentee.id, id: check_point.id, check_point: params
      end

      it 'does not update check_point' do
        expect(check_point.reload.start_date).to_not be_nil
      end

      it 'assigns @check_point' do
        expect(assigns(:check_point)).to eq(check_point)
      end

      it 'render :new template' do
        is_expected.to render_template(:edit)
      end
    end
  end

  describe 'POST finish' do
    let(:mocked_service) { double }
    before do
      allow(mocked_service).to receive(:finish!)
      allow(CheckPointService).to receive(:new).and_return(mocked_service)
    end

    it 'finishes current check_point and starts new one' do
      expect(mocked_service).to receive(:finish!)
      post :finish, mentee_id: mentee.id, id: check_point.id
    end

    it 'redirects to :index' do
      post :finish, mentee_id: mentee.id, id: check_point.id
      is_expected.to redirect_to(mentee_check_points_path)
    end
  end
end
