require 'rails_helper'

describe 'Developer applies for vacancy' do
  it 'successfully' do
    category = ProjectCategory.create!(category: 'Front-end')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    Project.create!( title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                     requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                     maximum_value_per_hour: 150, end_date: 5.days.from_now, working_model: 1, project_category: category,
                     project_owner: kurt )
    darth = Developer.create!(email: 'darth@vader.com.br', password: '123456789')
    DeveloperProfile.create!(full_name: 'Anakin Skywalker', social_name: 'Anakin', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: darth)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Desenvolvedor de Sites'
    fill_in 'Motivação', with: 'Tenho experiencia na área de desenvolvimento e pretendo focar minha carreira apenas nisso, além de ter gostado da proposta'
    fill_in 'Horas Semanais Disponíveis', with: 40
    click_on 'Candidate-se'

    expect(page).to have_content('Proposta enviada com sucesso!')
    expect(page).to have_content('Avaliaremos seu perfil e em breve retornaremos uma resposta.')
    expect(page).to have_content('Motivação: Tenho experiencia na área de desenvolvimento e pretendo focar minha carreira apenas nisso, além de ter gostado da proposta')
    expect(page).to have_content('Horas Semanais Disponíveis: 40')
    expect(page).to have_content("Proposta enviada em: #{I18n.l(Proposal.last.created_at, format: :long)}")
    expect(page).to have_content('Situação da Proposta: Pendente')
  end

  it 'and there should be no blank fields' do
    category = ProjectCategory.create!(category: 'Front-end')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    Project.create!( title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                     requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                     maximum_value_per_hour: 150, end_date: 5.days.from_now, working_model: 1, project_category: category,
                     project_owner: kurt )
    darth = Developer.create!(email: 'darth@vader.com.br', password: '123456789')
    DeveloperProfile.create!(full_name: 'Anakin Skywalker', social_name: 'Anakin', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: darth)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Desenvolvedor de Sites'
    click_on 'Candidate-se'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'unsuccessful due to lack of profile' do
    category = ProjectCategory.create!(category: 'Front-end')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    Project.create!( title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                     requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                     maximum_value_per_hour: 150, end_date: 5.days.from_now, working_model: 1, project_category: category,
                     project_owner: kurt )
    darth = Developer.create!(email: 'darth@vader.com.br', password: '123456789')

    login_as darth, scope: :developer
    visit root_path
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_link('Complete seu perfil para candidatar-se a vaga.')
  end

end
