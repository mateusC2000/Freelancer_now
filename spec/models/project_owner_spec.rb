require 'rails_helper'

describe ProjectOwner do
  it { should have_many(:projects) }
end
