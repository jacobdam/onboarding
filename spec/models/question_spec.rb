require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to have_one(:answer) }
end
