require 'rails_helper'

describe 'Developer cannot see form for a proposal already made' do
  it 'successfully' do
    category = ProjectCategory.create!(category: 'Front-end')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    kproject = Project.create!({ title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                                 requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                                 maximum_value_per_hour: 10, end_date: 5.days.from_now, working_model: 1,
                                 project_category: category, project_owner: kurt })

    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    Proposal.create!({ motivation: 'Por pura diversão', weekly_hours_available: 40,
                       project: kproject, developer: bellamy })

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Desenvolvedor de Sites'

    expect(page).not_to have_content('Candidatar-se a vaga')
    expect(page).not_to have_button('Candidate-se')
    expect(page).to have_content('Você já enviou proposta a esse projeto.')
    expect(page).to have_link('Minhas Propostas', href: user_project_proposals_path(kproject))
  end
end
