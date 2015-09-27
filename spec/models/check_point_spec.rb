require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  it { is_expected.to belong_to(:mentee) }
  it { is_expected.to have_one(:question) }

  describe '.past_and_current' do
    let!(:check_point) { create(:check_point, start_date: start_date) }
    subject { described_class.past_and_current.pluck(:id) }

    context 'when start date is in the past' do
      let(:start_date) { 2.days.ago }
      it { is_expected.to eq [check_point.id] }
    end

    context 'when start date is in the future' do
      let(:start_date) { 2.days.from_now }
      it { is_expected.to eq [] }
    end
  end

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

  describe '#should_have_started' do
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
