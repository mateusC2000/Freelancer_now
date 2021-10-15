require 'rails_helper'

describe Developer do
  it { should have_many(:proposals) }
  it { should have_many(:projects).through(:proposals) }
  it { should have_one(:developer_profile) }
end
