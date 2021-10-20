require 'rails_helper'

describe 'Visitor visits home page' do
  it 'successfuly' do

    visit root_path

    expect(page).to have_content('FreelancerNow')
    expect(page).to have_content('Sua próxima contratação está aqui!')
  end

  it 'and sees available projects' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    Project.create!(title: 'Desenvolvedor de Sites',
                    description: 'Desenvolvimento de sites e-commerce e institucionais',
                    requirements: 'Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO',
                    maximum_value_per_hour: 10, end_date: '20/11/2021', working_model: 2, project_owner: teu)
                    
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
end
