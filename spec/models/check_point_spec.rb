require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  it { is_expected.to belong_to(:mentee) }
  it { is_expected.to have_one(:question) }

  describe 'states' do
    subject { create(:check_point) }

    context 'after create' do
      it 'has state of :unstarted' do
        is_expected.to be_unstarted
      end
    end

    context 'when start!' do
      include ActiveSupport::Testing::TimeHelpers
      let(:started_time) { Time.new(2015, 9, 26, 1, 2, 3) }

      before do
        travel_to started_time do
          subject.start!
        end
      end

      it 'changes to :started' do
        is_expected.to be_started
      end

      it 'sets started_at' do
        expect(subject.started_at).to eq(started_time)
      end
    end

    context 'when finish!' do
      before do
        subject.start!
        subject.finish!
      end

      it 'changes to :finished' do
        is_expected.to be_finished
      end
    end
  end
end
