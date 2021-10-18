require 'rails_helper'

describe 'Project owner view own projects' do
  it 'using menu' do
    project_owner = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as project_owner, scope: :project_owner
    visit root_path

    expect(page).to have_link('Meus Projetos', href: my_projects_admin_projects_path)
  end

  it 'and should view owned projects' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    Project.create!({ title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                      requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                      maximum_value_per_hour: 10, end_date: '30/12/2021', working_model: 1, project_owner: teu })

    Project.create!({ title: 'Desenvolvedor de Aplicativos', description: 'Desenvolvimento de apps e-commerce e institucionais',
                      requirements: 'Buscamos pessoas com experiência em e-commerce, JS, Java e C#',
                      maximum_value_per_hour: 15, end_date: '20/12/2021', working_model: 2, project_owner: kurt })

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).not_to have_content('Desenvolvedor de Aplicativos')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and has no properties yet' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_content 'Você ainda não cadastrou projetos'
    expect(page).to have_link('Cadastre seu primeiro projeto agora', href: new_admin_project_path)
  end

  it 'must be logged in to view a project' do
    teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    project = Project.create!({ title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                                requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                                maximum_value_per_hour: 10, end_date: '15/12/2021', working_model: 1, project_owner: teu })

    visit admin_project_path(project)

    expect(current_path).to eq(new_project_owner_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
