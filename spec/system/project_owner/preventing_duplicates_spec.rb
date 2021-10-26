require 'rails_helper'

describe 'Preventing duplicates' do
  it 'of accept' do
    category = ProjectCategory.create!(category: 'Front-end')
    joe = ProjectOwner.create!(email: 'joe@goldberg.com.br', password: '123456789')
    project = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                               requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                               maximum_value_per_hour: 10, end_date: '30/11/2021', working_model: 1,
                               project_category: category, project_owner: joe)
    love = Developer.create!(email: 'love@quinn', password: '123456')
    DeveloperProfile.create!(full_name: 'Love Quinn', social_name: 'love', date_birth: '09/10/1985',
                             academic_formation: 'Graduada em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedora nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como SimpleCode e StarCode.',
                             developer: love)
    Proposal.create!(motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                     weekly_hours_available: 40, project: project, developer: love, status: :pending)

    login_as joe, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Desenvolvedor de Sites'
    click_on 'Aceitar Proposta'
    
    expect(current_path).to eq(admin_project_path(project))
    expect(page).not_to have_button('Aceitar Proposta')
  end

  it 'of recused' do
    category = ProjectCategory.create!(category: 'Front-end')
    joe = ProjectOwner.create!(email: 'joe@goldberg.com.br', password: '123456789')
    project = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                               requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                               maximum_value_per_hour: 10, end_date: '30/11/2021', working_model: 1,
                               project_category: category, project_owner: joe)
    love = Developer.create!(email: 'love@quinn', password: '123456')
    DeveloperProfile.create!(full_name: 'Love Quinn', social_name: 'love', date_birth: '09/10/1985',
                             academic_formation: 'Graduada em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedora nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como SimpleCode e StarCode.',
                             developer: love)
    Proposal.create!(motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                     weekly_hours_available: 40, project: project, developer: love, status: :pending)

    login_as joe, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Desenvolvedor de Sites'
    click_on 'Recusar Proposta'

    expect(current_path).to eq(admin_project_path(project))
    expect(page).not_to have_button('Recusar Proposta')
  end
end
