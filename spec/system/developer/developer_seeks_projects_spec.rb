require 'rails_helper'

describe 'Developer seeks projects' do
  it 'successfully' do
    category = ProjectCategory.create!(category: 'Front-end')
    other_category = ProjectCategory.create!(category: 'Back-end')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                    requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                    maximum_value_per_hour: 10, end_date: '30/11/2021', working_model: 1,
                    project_category: other_category, project_owner: kurt)

    john = ProjectOwner.create!(email: 'john@mmurphy.com.br', password: '1234567')
    Project.create!(title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                    requirements: 'Buscamos devs com experiência na área de front-end',
                    maximum_value_per_hour: 25, end_date: '30/11/2021', working_model: 1,
                    project_category: category, project_owner: john)

    love = ProjectOwner.create!(email: 'love@quinn.com.br', password: '1234567')
    Project.create!(title: 'Desenvolvedor de Aplicativos', description: 'Aprimoramento de site de imóveis com front-end',
                    requirements: 'Buscamos desensolvedores com experiências em front-end e ',
                    maximum_value_per_hour: 25, end_date: '30/11/2021', working_model: 1,
                    project_category: category, project_owner: love)

    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    login_as bellamy, scope: :developer
    visit root_path
    find(:id, 'q').set('Desenvolvedor')
    click_on 'Pesquisar'

    expect(current_path).to eq(search_user_projects_path)
    expect(page).to have_content('Desenvolvedor de Aplicativos')
    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).not_to have_content('Front on Fire')
  end
end
