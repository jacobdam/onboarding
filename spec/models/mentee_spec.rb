require 'rails_helper'

RSpec.describe Mentee, type: :model do
  describe '#current_check_point' do
    let(:mentee) { create(:mentee) }
    let!(:check_point) { create(:check_point, mentee: mentee, status: status) }
    subject { mentee.current_check_point }

    context 'when check point is started' do
      let(:status) { 1 }
      it { is_expected.to eq check_point }
    end

    context 'when check point is not started' do
      let(:status) { 0 }
      it { is_expected.to eq nil }
    end
  end
end
