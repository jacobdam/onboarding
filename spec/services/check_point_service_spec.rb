require 'rails_helper'

RSpec.describe CheckPointService do
  let(:mentee) { FactoryGirl.create(:mentee) }
  let(:check_point) { FactoryGirl.create(:check_point, start_date: 7.days.ago.to_date, mentee: mentee) }
  let!(:next_check_point) { FactoryGirl.create(:check_point, start_date: next_check_point_start_date, mentee: mentee) }
  let!(:next_check_point_start_date) { 1.days.ago.to_date }

  subject do
    check_point.start!
    CheckPointService.new(check_point)
  end

  describe '#finish!' do
    it 'finish the check point and start the next check point' do
      subject.finish!
      expect(check_point.reload).to be_finished
      expect(next_check_point.reload).to be_started
    end
  end

  describe '#try_to_finish' do
    context 'next check point should have started' do
      it 'calls finish' do
        subject.try_to_finish
        expect(check_point.reload).to be_finished
        expect(next_check_point.reload).to be_started
      end
    end

    context 'next check point should not started yet' do
      let!(:next_check_point_start_date) { 1.days.from_now.to_date }
      
      it 'does not calls finish' do
        subject.try_to_finish
        expect(check_point.reload).to be_started
        expect(next_check_point.reload).to be_unstarted
      end
    end
  end

  describe 'next_check_point' do
    it 'returns the next check point that unstarted, order by start date' do
      expect(subject.next_check_point).to eq next_check_point
    end
  end
end
