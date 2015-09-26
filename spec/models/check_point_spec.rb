require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  describe '#should_have_started?' do
    let(:check_point) { FactoryGirl.create(:check_point, start_date: start_date) }

    context 'when it start date have past today' do
      let(:start_date) { 2.days.ago.to_date }

      it 'returns true' do
        expect(check_point.should_have_started?).to be_truthy
      end
    end

    context 'when it start date have NOT past today' do
      let(:start_date) { 2.days.from_now.to_date }

      it 'returns false' do
        expect(check_point.should_have_started?).to be_falsey
      end
    end
  end
end
