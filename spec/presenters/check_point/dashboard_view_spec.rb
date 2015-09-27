require 'rails_helper'

describe CheckPoint::DashboardView do
  describe '#answer' do
    let(:answer_value) { 7 }
    let(:answer) { double('Answer', answer_value: answer_value) }
    let(:check_point) { double('CheckPoint') }
    let(:user) { double('User') }
    let(:presenter) { described_class.new(check_point, user) }
    subject { presenter.answer }

    before do
      expect(check_point).to receive(:answer_of_mentor)
        .with(user).and_return(answer)
    end

    it { is_expected.to eq answer_value }
  end
end
