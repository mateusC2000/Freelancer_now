require 'rails_helper'

describe Proposal do
  it { should belong_to(:project) }
  it { should belong_to(:developer) }

  it { should validate_presence_of(:motivation).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:weekly_hours_available).with_message('não pode ficar em branco') }

  it { should validate_numericality_of(:weekly_hours_available).is_greater_than(0) }

  it 'successfully' do
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    kproject = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                               requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                               maximum_value_per_hour: 10, end_date: 5.days.from_now, working_model: 1, project_owner: kurt)
    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)
    Proposal.create!(motivation: 'Por pura diversão', weekly_hours_available: 40,
                     project: kproject, developer: bellamy)

    proposal = Proposal.new(motivation: 'Por pura diversão', weekly_hours_available: 40,
                            project: kproject, developer: bellamy)
    proposal.valid?
    expect(proposal.valid?).to eq(false)
  end
end
