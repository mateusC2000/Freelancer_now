require 'rails_helper'

describe Project do
  
  it { should validate_presence_of(:title).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:requirements).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:maximum_value_per_hour).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:end_date).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:working_model).with_message('não pode ficar em branco') }

  it { should validate_numericality_of(:maximum_value_per_hour).is_greater_than(0) }

  xit 'end date is in the past' do
    
  end
end
