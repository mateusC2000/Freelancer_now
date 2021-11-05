require 'rails_helper'

describe ProjectCategory do
  it { should have_many(:projects) }
  it { should validate_presence_of(:category).with_message('não pode ficar em branco') }
end
