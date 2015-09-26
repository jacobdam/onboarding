require 'rails_helper'

describe CheckPointsController, type: :controller do
  let(:mentor) { create(:user) }

  before do
    sign_in(mentor)
  end

  describe '#question' do
    let(:mentorship) { create(:mentorship, mentee: mentee, user: mentor) }
    let(:mentee) { create(:mentee) }
    let(:check_point) { create(:check_point, mentee: mentee) }
    let!(:question) { create(:question, check_point: check_point) }

    it 'renders correct data' do
      get :question, mentee_id: mentee.id, id: check_point.id

      expect(response).to be_success
      expect(assigns[:question]).to eq question
      expect(assigns[:answer]).to be_new_record
      expect(assigns[:answer].question_id).to eq question.id
      expect(assigns[:answer].user_id).to eq mentor.id
    end
  end

  describe '#answer' do
    let(:mentorship) { create(:mentorship, mentee: mentee, user: mentor) }
    let(:mentee) { create(:mentee) }
    let(:check_point) { create(:check_point, mentee: mentee) }
    let!(:question) { create(:question, check_point: check_point) }
    let(:note) { 'note' }
    let(:answer_params) { {
      question_id: question.id,
      answer_value: answer_value,
      note: note
    } }

    context 'when answer can be created' do
      let(:answer_value) { 1 }

      it 'creates answer' do
        expect {
          post :answer, answer: answer_params, id: check_point.id, mentee_id: mentee.id
        }.to change { question.reload.answer }.from(nil)

        expect(assigns[:answer].note).to eq note
        expect(assigns[:answer].question_id).to eq question.id
        expect(assigns[:answer].user_id).to eq mentor.id
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'when answer can not be created' do
      let(:answer_value) { nil }

      it 'renders error' do
        expect {
          post :answer, answer: answer_params, id: check_point.id, mentee_id: mentee.id
        }.not_to change { question.reload.answer }

        expect(response).to render_template(:question)
        expect(assigns[:question]).to eq question
      end
    end

    it 'renders correct data' do
      get :question, mentee_id: mentee.id, id: check_point.id

      expect(assigns[:answer]).to be_new_record
      expect(assigns[:answer].question_id).to eq question.id
      expect(assigns[:answer].user_id).to eq mentor.id
    end
  end
end
