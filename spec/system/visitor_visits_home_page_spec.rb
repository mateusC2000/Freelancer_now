require 'rails_helper'

describe 'Visitor visits home page' do
  it 'successfuly' do

    visit root_path

    expect(page).to have_content('FreelancerNow')
    expect(page).to have_content('Sua próxima contratação está aqui!')
  end

  it 'and sees available projects' do
    category = ProjectCategory.create!(category: 'Front-end')
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    Project.create!(title: 'Desenvolvedor de Sites',
                    description: 'Desenvolvimento de sites e-commerce e institucionais',
                    requirements: 'Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO',
                    maximum_value_per_hour: 10, end_date: '20/11/2021', working_model: 2,
                    project_category: category, project_owner: teu)
                    
    visit root_path
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).to have_content('Desenvolvimento de sites e-commerce e institucionais')
    expect(page).to have_content('Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO')
    expect(page).to have_content('Máximo pago por hora: R$ 10,00')
    expect(page).to have_content('Último dia útil: 20/11/2021')
    expect(page).to have_content('Remoto')
    expect(page).to have_link('Voltar')
  end

  it 'and search projects' do
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

    visit root_path
    find(:id, 'q').set('Desenvolvedor')
    click_on 'Pesquisar'

    expect(page).to have_content('Desenvolvedor de Aplicativos')
    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).not_to have_content('Front on Fire')

  end
end
