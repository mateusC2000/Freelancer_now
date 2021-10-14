require 'rails_helper'

describe 'Project owner view proposals' do
  it 'should view proposals from owned projects' do
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    kproject = Project.create!({ title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                                 requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                                 maximum_value_per_hour: 10, end_date: '15/10/2021', working_model: 1, project_owner: kurt })

    john = ProjectOwner.create!(email: 'john@mmurphy.com.br', password: '1234567')
    jproject = Project.create!({ title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                                 requirements: 'Buscamos devs com experiência na área de front-end',
                                 maximum_value_per_hour: 25, end_date: '22/10/2021', working_model: 1, project_owner: john })

    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    Proposal.create!({ motivation: 'Por pura diversão', weekly_hours_available: 40,
                       project: kproject, developer: bellamy })

    Proposal.create!({ motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                       weekly_hours_available: 40, project: jproject, developer: bellamy })

    login_as kurt, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Proposta de Bellamy Blake')
    expect(page).to have_link('Bellamy Blake')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content(/40/)
    expect(page).to have_button('Aceitar Proposta')
    expect(page).to have_link('Recusar ')
  end

  it 'and does not view other projects proposal' do
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    kproject = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                               requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                               maximum_value_per_hour: 10, end_date: '15/10/2021', working_model: 1, project_owner: kurt)

    john = ProjectOwner.create!(email: 'john@mmurphy.com.br', password: '1234567')
    jproject = Project.create!(title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                               requirements: 'Buscamos devs com experiência na área de front-end',
                               maximum_value_per_hour: 25, end_date: '22/10/2021', working_model: 1, project_owner: john)

    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    Proposal.create!(motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                     weekly_hours_available: 40, project: jproject, developer: bellamy)

    login_as kurt, scope: :project_owner
    visit root_path
    click_on 'Front on Fire'

    expect(page).not_to have_content('Proposta de Bellamy Blake')
    expect(page).not_to have_link('Bellamy Blake')
    expect(page).not_to have_content('Motivação: Por pura diversão')
    expect(page).not_to have_content(/40/)
    expect(page).not_to have_button('Aceitar Proposta')
    expect(page).not_to have_button('Recusar Proposta')
  end

  it 'and accept proposal' do
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    kproject = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                               requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                               maximum_value_per_hour: 10, end_date: '15/10/2021', working_model: 1, project_owner: kurt)

    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)
    Proposal.create!(motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                     weekly_hours_available: 40, project: kproject, developer: bellamy)

    login_as kurt, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Desenvolvedor de Sites'
    click_on 'Aceitar Proposta'

    expect(current_path).to eq(admin_project_path(kproject))
    expect(page).to have_content('Proposta aceita com sucesso!')
    expect(page).to have_content('Proposta de Bellamy Blake')
    expect(page).to have_content('Motivação: Trabalhei na área por muito tempo e quero voltar a ativa.')
    expect(page).to have_content(/40/)
    expect(page).to have_content('Situação da Proposta: Aceita')
    expect(page).to have_link('Voltar', href: my_projects_admin_projects_path)
  end
end
