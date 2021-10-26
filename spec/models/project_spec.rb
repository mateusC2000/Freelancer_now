require 'rails_helper'

describe Project do
  it { should belong_to(:project_owner) }
  it { should have_many(:proposals) }
  it { should belong_to(:project_category) }
  
  it { should validate_presence_of(:title).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:requirements).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:maximum_value_per_hour).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:end_date).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:working_model).with_message('não pode ficar em branco') }

  it { should validate_numericality_of(:maximum_value_per_hour).is_greater_than(0) }

  it 'end date is in the past' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    project = Project.new( title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                           requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                           maximum_value_per_hour: 10, end_date: 2.days.ago, working_model: 1, project_owner: teu )

    project.valid?

    expect(project.valid?).to eq(false)
    expect(project.errors[:end_date]).to include('não pode ser em datas passadas')
  end
end
