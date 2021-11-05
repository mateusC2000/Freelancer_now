require 'rails_helper'

describe 'Developer seeks projects' do
  it 'successfully' do
    create(:project, title: 'Desenvolvedor de Sites')
    create(:project, title: 'Front on Fire')
    create(:project, title: 'Desenvolvedor de Aplicativos')
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)

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
