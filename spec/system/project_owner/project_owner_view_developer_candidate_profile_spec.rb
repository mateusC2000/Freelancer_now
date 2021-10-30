require 'rails_helper'

describe 'Project owner view developer candidate profile' do
  it 'successfully' do
    category = ProjectCategory.create!(category: 'Front-end')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    project = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                              requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                              maximum_value_per_hour: 10, end_date: '30/11/2021', working_model: 1,
                              project_category: category, project_owner: kurt)
    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    profile = DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)
    profile.image.attach(io: File.open('spec/images/profile.png'), filename: 'profile.png')

    Proposal.create!(motivation: 'Por pura diversão', weekly_hours_available: 40,
                     project: project, developer: bellamy, status: :pending)

    login_as kurt, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Desenvolvedor de Sites'
    click_on 'Bellamy Blake'

    expect(page).to have_css('img[src*="profile.png"]')
    expect(page).to have_content('Perfil do Candidato')
    expect(page).to have_content('Bellamy Blake')
    expect(page).to have_content('Bellamy')
    expect(page).to have_content('09/10/1985')
    expect(page).to have_content('Graduado em Ciências da Tecnologia e Ciências de Dados.')
    expect(page).to have_content('Sou desenvolvedor nas áreas de back-end e front-end.')
    expect(page).to have_content('Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.')
    expect(page).to have_link('Voltar')
  end
end
