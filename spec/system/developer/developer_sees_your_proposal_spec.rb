require 'rails_helper'

describe 'Developer sees your proposal' do
  it 'successfully' do
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

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'

    expect(page).to have_content('Minhas Propostas')
    expect(page).to have_link('Desenvolvedor de Sites')
    expect(page).to have_content('Status: Pendente')
    expect(page).not_to have_content('Front on Fire')
  end

  it 'see the details of an accepted proposal' do
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
                       project: kproject, developer: bellamy, status: :accepted })

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Sua proposta foi aceita! Enviaremos mais informações em instantes.')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content('Horas Semanais Disponíveis: 40')
    expect(page).to have_content("Proposta enviada em: #{I18n.l(Proposal.last.updated_at, format: :long)}")
    expect(page).to have_content('Situação da Proposta: Aceita')
  end

  it 'see details of a rejected proposal' do
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

    Proposal.create!({ motivation: 'Por pura diversão', weekly_hours_available: 20,
                       project: kproject, developer: bellamy, status: :recused })

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Após avaliarmos seu perfil, infelizmente tivemos que recusar a sua proposta.')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content('Horas Semanais Disponíveis: 20')
    expect(page).to have_content("Proposta enviada em: #{I18n.l(Proposal.last.updated_at, format: :long)}")
    expect(page).to have_content('Situação da Proposta: Recusada')
  end

  it 'must be logged in to view own proposals' do
    john = ProjectOwner.create!(email: 'john@mmurphy.com.br', password: '1234567')
    jproject = Project.create!({ title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                                 requirements: 'Buscamos devs com experiência na área de front-end',
                                 maximum_value_per_hour: 25, end_date: '22/10/2021', working_model: 1, project_owner: john })

    visit user_project_proposals_path(jproject)

    expect(current_path).to eq(new_developer_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

  it 'must be logged in to view details of proposal' do
    john = ProjectOwner.create!(email: 'john@mmurphy.com.br', password: '1234567')
    jproject = Project.create!({ title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                                 requirements: 'Buscamos devs com experiência na área de front-end',
                                 maximum_value_per_hour: 25, end_date: '22/10/2021', working_model: 1, project_owner: john })
    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    proposal = Proposal.create!({ motivation: 'Por pura diversão', weekly_hours_available: 20,
                                  project: jproject, developer: bellamy, status: :recused })

    visit user_project_proposal_path(jproject, proposal)

    expect(current_path).to eq(new_developer_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
