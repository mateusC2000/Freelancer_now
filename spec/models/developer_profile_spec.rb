require 'rails_helper'

describe DeveloperProfile do
  it { should belong_to(:developer) }

  it { should validate_presence_of(:full_name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:social_name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:date_birth).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:academic_formation).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:performance_zone).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:professional_experiences).with_message('não pode ficar em branco') }
end
