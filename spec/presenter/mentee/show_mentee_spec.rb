require 'rails_helper'

describe Mentee::ShowMentee do
  let(:mentee) { double('Mentee') }
  let(:presenter) { described_class.new(mentee) }

  describe '#progress_data' do
    let(:competence_index_progress_data) { 'competence_index_progress_data' }
    let(:average_expectation_progress_data) { 'average_expectation_progress_data' }
    let(:result) { [
      {
        name: 'Competence Index',
        data: competence_index_progress_data
      },
      {
        name: 'Average Expectation',
        data: average_expectation_progress_data
      }
    ] }
    let(:calculator) { instance_double('Mentee::ExpectationCalculator',
                                       competence_index_progress_data: competence_index_progress_data,
                                       average_expectation_progress_data: average_expectation_progress_data) }
    subject { presenter.progress_data }

    before do
      expect(Mentee::ExpectationCalculator).to receive(:new)
        .with(mentee).and_return(calculator)
    end

    it { is_expected.to eq result }
  end
end
