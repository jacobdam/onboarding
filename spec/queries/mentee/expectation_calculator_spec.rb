require 'rails_helper'

describe Mentee::ExpectationCalculator do
  let(:mentee) { create(:mentee) }
  let(:query) { described_class.new(mentee) }

  describe '#competence_index' do
    let(:check_point) { create(:check_point, :started, mentee: mentee) }
    let(:question) { create(:question, check_point: check_point) }
    let(:value_1) { 9 }
    let(:value_2) { 7 }
    let(:value_3) { 6 }
    let!(:answer_1) { create(:answer, question: question, answer_value: value_1) }
    let!(:answer_2) { create(:answer, question: question, answer_value: value_2) }
    let!(:answer_3) { create(:answer, question: question, answer_value: value_3) }
    subject { query.competence_index }
    it { is_expected.to eq 0 }
  end

  describe '#average_expectation' do
    let(:check_point) { create(:check_point, :started, mentee: mentee) }
    let(:question) { create(:question, check_point: check_point) }
    let(:value_1) { 9 }
    let(:value_2) { 8 }
    let(:value_3) { 4 }
    let!(:answer_1) { create(:answer, question: question, answer_value: value_1) }
    let!(:answer_2) { create(:answer, question: question, answer_value: value_2) }
    let!(:answer_3) { create(:answer, question: question, answer_value: value_3) }
    subject { query.average_expectation }
    it { is_expected.to eq 7 }
  end

  describe '#current_check_point_data' do
    let(:check_point) { create(:check_point, :started, mentee: mentee) }
    let(:question) { create(:question, check_point: check_point) }
    let(:value_1) { 9 }
    let(:value_2) { 7 }
    let(:value_3) { 7 }
    let!(:answer_1) { create(:answer, question: question, answer_value: value_1) }
    let!(:answer_2) { create(:answer, question: question, answer_value: value_2) }
    let!(:answer_3) { create(:answer, question: question, answer_value: value_3) }
    let(:result) { { 9 => 1, 7 => 2 } }
    subject { query.current_check_point_data }
    it { is_expected.to eq result }
  end

  describe '#competence_index_progress_data' do
  end

  describe '#average_expectation_progress_data' do
  end
end
