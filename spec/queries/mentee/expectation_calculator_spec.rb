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
    let(:start_date_1) { 1.day.ago }
    let(:start_date_2) { 10.day.ago }
    let(:check_point_1) { create(:check_point, :started, mentee: mentee, start_date: start_date_1) }
    let(:check_point_2) { create(:check_point, :finished, mentee: mentee, start_date: start_date_2) }
    let(:question_1) { check_point_1.question }
    let(:question_2) { check_point_2.question }
    let(:value_1) { 9 }
    let(:value_2) { 7 }
    let(:value_3) { 7 }
    let!(:answer_1) { create(:answer, question: question_1, answer_value: value_1) }
    let!(:answer_2) { create(:answer, question: question_1, answer_value: value_2) }
    let!(:answer_3) { create(:answer, question: question_2, answer_value: value_3) }
    let(:result) { [[start_date_2.to_date, 0], [start_date_1.to_date, 1]] }
    subject { query.competence_index_progress_data }
    it { is_expected.to eq result }
  end

  describe '#average_expectation_progress_data' do
    let(:start_date_1) { 1.day.ago }
    let(:start_date_2) { 10.day.ago }
    let(:check_point_1) { create(:check_point, :started, mentee: mentee, start_date: start_date_1) }
    let(:check_point_2) { create(:check_point, :finished, mentee: mentee, start_date: start_date_2) }
    let(:question_1) { check_point_1.question }
    let(:question_2) { check_point_2.question }
    let(:value_1) { 9 }
    let(:value_2) { 7 }
    let(:value_3) { 7 }
    let!(:answer_1) { create(:answer, question: question_1, answer_value: value_1) }
    let!(:answer_2) { create(:answer, question: question_1, answer_value: value_2) }
    let!(:answer_3) { create(:answer, question: question_2, answer_value: value_3) }
    let(:result) { [[start_date_2.to_date, 7], [start_date_1.to_date, 8]] }
    subject { query.average_expectation_progress_data }
    it { is_expected.to eq result }
  end
end
