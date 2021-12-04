require 'rails_helper'

describe 'Developer cannot see form for a proposal already made' do
  it 'successfully' do
    project = create(:project, title: 'Desenvolvedor de Sites')
    darth = create(:developer)
    create(:developer_profile, developer: darth)
    create(:proposal, project: project, developer: darth)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Ver Informações do Projeto'

    expect(page).not_to have_content('Candidatar-se a vaga')
    expect(page).not_to have_button('Candidate-se')
    expect(page).to have_content('Você já enviou proposta a esse projeto.')
    expect(page).to have_link('Minhas Propostas', href: user_project_proposals_path(project))
  end
end
