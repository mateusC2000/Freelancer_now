require 'rails_helper'

describe 'Developer filters projects by category' do
  it 'using links on home page' do
    back = create(:project_category, category: 'Back-end')
    front = create(:project_category, category: 'Front-end')
    create(:project, title: 'Desenvolvedor de Aplicativos', project_category: back)
    create(:project, title: 'Desenvolvedor de Sites', project_category: front)
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Projetos por Categorias'
    click_on 'Back-end'

    expect(page).to have_link('Desenvolvedor de Aplicativos')
    expect(page).not_to have_link('Desenvolvedor de Sites')
  end
end
