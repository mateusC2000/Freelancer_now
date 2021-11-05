require 'rails_helper'

describe 'Project owner view own projects' do
  it 'using menu' do
    teu = create(:project_owner)

    login_as teu, scope: :project_owner
    visit root_path

    expect(page).to have_link('Meus Projetos', href: my_projects_admin_projects_path)
  end

  it 'and should view owned projects' do
    teu = create(:project_owner)
    kurt = create(:project_owner)
    create(:project, project_owner: teu, title: 'Desenvolvedor de Sites')
    create(:project, project_owner: kurt, title: 'Desenvolvedor de Aplicativos')

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).not_to have_content('Desenvolvedor de Aplicativos')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and has no properties yet' do
    teu = create(:project_owner)

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_content 'Você ainda não cadastrou projetos'
    expect(page).to have_link('Cadastre seu primeiro projeto agora', href: new_admin_project_path)
  end

  it 'must be logged in to view a project' do
    teu = create(:project_owner)
    project = create(:project, project_owner: teu)

    visit admin_project_path(project)

    expect(current_path).to eq(new_project_owner_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
