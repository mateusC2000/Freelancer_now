require 'rails_helper'

describe Proposal do
  it { should belong_to(:project) }
  it { should belong_to(:developer) }

  it { should validate_presence_of(:motivation).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:weekly_hours_available).with_message('não pode ficar em branco') }

  it { should validate_numericality_of(:weekly_hours_available).is_greater_than(0) }

end
