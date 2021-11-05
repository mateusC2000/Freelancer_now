require 'rails_helper'

describe 'Developer cancels the proposal made to the project' do
  it 'successfully' do
    project = create(:project, title: 'Front on Fire')
    darth = create(:developer)
    create(:developer_profile, developer: darth)
    create(:proposal, project: project, developer: darth)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Front on Fire'
    click_on 'Cancelar Proposta'

    expect(page).to have_content('Proposta cancelada com sucesso!')
    expect(page).to have_content('Situação da Proposta: Cancelada')
  end
end
