require 'rails_helper'

describe 'Developer sees your proposal' do
  it 'successfully' do
    project = create(:project, title: 'Desenvolvedor de Sites')
    create(:project, title: 'Front on Fire')
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)
    create(:proposal, project: project, developer: bellamy)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'

    expect(page).to have_content('Minhas Propostas')
    expect(page).to have_link('Desenvolvedor de Sites')
    expect(page).to have_content('Status: Pendente')
    expect(page).not_to have_content('Front on Fire')
  end

  it 'see the details of an accepted proposal' do
    project = create(:project, title: 'Desenvolvedor de Sites')
    create(:project, title: 'Front on Fire')
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)
    create(:proposal, project: project, developer: bellamy, status: :accepted)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Sua proposta foi aceita! Enviaremos mais informações em instantes.')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content('Horas Semanais Disponíveis: 40')
    expect(page).to have_content("Proposta enviada em: #{I18n.l(Proposal.last.updated_at, format: :long)}")
    expect(page).to have_content('Situação da Proposta: Aceita')
  end

  it 'see details of a rejected proposal' do
    project = create(:project, title: 'Desenvolvedor de Sites')
    create(:project, title: 'Front on Fire')
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)
    create(:proposal, project: project, developer: bellamy, status: :recused)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Após avaliarmos seu perfil, infelizmente tivemos que recusar a sua proposta.')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content('Horas Semanais Disponíveis: 40')
    expect(page).to have_content("Proposta enviada em: #{I18n.l(Proposal.last.updated_at, format: :long)}")
    expect(page).to have_content('Situação da Proposta: Recusada')
  end

  it 'must be logged in to view own proposals' do
    project = create(:project, title: 'Desenvolvedor de Sites')

    visit user_project_proposals_path(project)

    expect(current_path).to eq(new_developer_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

  it 'must be logged in to view details of proposal' do
    project = create(:project, title: 'Desenvolvedor de Sites')
    bellamy = create(:developer)
    proposal = create(:proposal, project: project, developer: bellamy, status: :recused)

    visit user_project_proposal_path(project, proposal)

    expect(current_path).to eq(new_developer_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

  it 'in blank' do
    create(:project, title: 'Desenvolvedor de Sites')
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'

    expect(page).to have_content('Minhas Propostas')
    expect(page).to have_content('Não há propostas em andamento.')
  end
end
