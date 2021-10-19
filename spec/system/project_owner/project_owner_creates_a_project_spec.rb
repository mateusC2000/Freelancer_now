require 'rails_helper'

describe 'Project Owner creates a project' do
  it 'successfully' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Cadastrar Projeto'
    select 'Remoto', from: 'Modelo de trabalho'
    fill_in 'Título', with: 'Desenvolvedor de Sites'
    fill_in 'Descrição', with: 'Desenvolvimento de sites e-commerce e institucionais'
    fill_in 'Requerimentos', with: 'Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO'
    fill_in 'Valor máximo por hora', with: 10
    fill_in 'Último dia útil', with: '30/11/2021'
    click_on 'Criar Projeto'

    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).to have_content('Desenvolvimento de sites e-commerce e institucionais')
    expect(page).to have_content('Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO')
    expect(page).to have_content('Máximo pago por hora: R$ 10,00')
    expect(page).to have_content('Último dia útil: 30/11/2021')
    expect(page).to have_content('Remoto')
    expect(page).to have_link('Voltar', href: my_projects_admin_projects_path)
  end

  it 'and there should be no blank fields' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :project_owner
    visit new_admin_project_path
    click_on 'Criar Projeto'

    expect(page).to have_content('não pode ficar em branco', count: 6)
  end

  it 'must be logged in to creates a project' do

    visit new_admin_project_path

    expect(current_path).to eq(new_project_owner_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
