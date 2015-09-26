require 'rails_helper'

RSpec.describe MenteesController, type: :controller do
  let(:company) { create(:company) }
  let(:current_user) { create(:user, :admin, company: company) }
  before do
    sign_in current_user
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:mentor_1) { create(:user) }
    let(:mentor_2) { create(:user) }

    context 'valid params' do
      let(:params) { attributes_for(:mentee).merge(mentor_ids: [mentor_1.id, mentor_2]) }

      it "creates new mentee with mentors" do
        expect {
          post :create, mentee: params
        }.to change { Mentee.count }.by(1)
        mentee = Mentee.last
        expect(mentee.mentors).to match_array([mentor_1, mentor_2])
      end

      it "redirects to index" do
        post :create, mentee: params
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(mentee_path(Mentee.last))
      end
    end

    context 'invalid params' do
      let(:params) { { mentor_ids: [] } }

      it "does not create new mentee" do
        expect {
          post :create, mentee: params
        }.to_not change { Mentee.count }
      end

      it "render :show template" do
        post :create, mentee: params
        is_expected.to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let!(:mentee) { create(:mentee, company: company) }

    it "returns http success" do
      get :update, id: mentee.id, mentee: { name: 'Updated name' }
      expect(response).to redirect_to(mentee_path(mentee))
      expect(mentee.reload.name).to eq 'Updated name'
    end
  end

  describe "GET #edit" do
    let!(:mentee) { create(:mentee, company: company) }

    it "returns http success" do
      get :edit, id: mentee.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    let!(:mentee) { create(:mentee, company: company) }

    it "returns http success" do
      get :destroy, id: mentee.id
      expect(Mentee.where(id: mentee.id)).to_not exist
      expect(response).to redirect_to(mentees_path)
    end
  end

  describe "GET #show" do
    let!(:mentee) { create(:mentee, company: company) }

    it "returns http success" do
      get :show, id: mentee.id
      expect(response).to have_http_status(:success)
    end
  end

end
