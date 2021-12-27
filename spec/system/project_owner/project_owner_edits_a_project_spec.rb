require 'rails_helper'

describe 'Project owner edits a project' do
  it 'successfully' do
    teu = create(:project_owner)
    create(:project, title: 'Desenvolvedor de Sites', project_owner: teu)

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Desenvolvedor de Sites'
    click_on 'Editar Projeto'
    select 'Front-end', from: 'Categoria'
    select 'Remoto', from: 'Modelo de trabalho'
    fill_in 'Título', with: 'Desenvolvedor de Apps'
    fill_in 'Descrição', with: 'Desenvolvimento de aplicativos e minigames'
    fill_in 'Requerimentos', with: 'Buscamos pessoas com experiência em Java, JS'
    fill_in 'Valor máximo por hora', with: 30
    fill_in 'Último dia útil', with: '25/12/2022'
    click_on 'Atualizar Projeto'

    expect(page).to have_content('Projeto atualizado com sucesso')
    expect(page).to have_content('Desenvolvedor de Apps')
    expect(page).to have_content('Desenvolvimento de aplicativos e minigames')
    expect(page).to have_content('Buscamos pessoas com experiência em Java, JS')
    expect(page).to have_content('Máximo pago por hora: R$ 30,00')
    expect(page).to have_content('Último dia útil: 25/12/2022')
    expect(page).to have_content('Remoto')
    expect(page).to have_link('Voltar', href: my_projects_admin_projects_path)
  end

  it 'and must fill in all fields' do
    teu = create(:project_owner)
    create(:project, project_owner: teu, title: 'Desenvolvedor de Sites')

    login_as teu, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Desenvolvedor de Sites'
    click_on 'Editar Projeto'
    select 'Remoto', from: 'Modelo de trabalho'
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Requerimentos', with: ''
    fill_in 'Valor máximo por hora', with: ''
    fill_in 'Último dia útil', with: ''
    click_on 'Atualizar Projeto'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end
end
