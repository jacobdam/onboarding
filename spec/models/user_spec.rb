require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many(:mentorships) }
  it { is_expected.to have_many(:mentees).through(:mentorships) }
end
