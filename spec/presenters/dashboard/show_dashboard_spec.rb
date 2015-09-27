require 'rails_helper'

describe Dashboard::ShowDashboard do
  let(:user) { create(:user) }
  let(:presenter) { described_class.new(user) }

  describe '#answered_check_points' do
    let(:mentee) { user.mentees.first }
    let(:question) { answered_check_point.question }
    let(:user) { create(:user, :mentor_with_mentee) }
    let!(:answer) { create(:answer, question: question, user_id: user.id) }
    let(:answered_check_point) { create(:check_point, :started, mentee: mentee) }
    subject { presenter.answered_check_points.map(&:check_point) }
    it { is_expected.to eq [answered_check_point] }
  end

  describe '#unanswered_check_points' do
    let(:mentee) { user.mentees.first }
    let(:user) { create(:user, :mentor_with_mentee) }
    let!(:unanswered_check_point) { create(:check_point, :started, mentee: mentee) }
    subject { presenter.unanswered_check_points.map(&:check_point) }
    it { is_expected.to eq [unanswered_check_point] }
  end
end
