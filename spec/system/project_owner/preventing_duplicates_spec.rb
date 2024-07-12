require 'rails_helper'

describe 'Preventing duplicates' do
  it 'of accept' do
    joe = create(:project_owner)
    project = create(:project, title: 'Desenvolvedor de Sites', project_owner: joe)
    love = create(:developer)
    create(:developer_profile, developer: love)
    create(:proposal, project: project, developer: love)

    login_as joe, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Ver Detalhes'
    click_on 'Aceitar Proposta'

    expect(current_path).to eq(admin_project_path(project))
    expect(page).not_to have_button('Aceitar Proposta')
  end

  it 'of recused' do
    joe = create(:project_owner)
    project = create(:project, title: 'Desenvolvedor de Sites', project_owner: joe)
    love = create(:developer)
    create(:developer_profile, developer: love)
    create(:proposal, project: project, developer: love)

    login_as joe, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Ver Detalhes'
    click_on 'Recusar Proposta'

    expect(current_path).to eq(admin_project_path(project))
    expect(page).not_to have_button('Recusar Proposta')
  end
end
