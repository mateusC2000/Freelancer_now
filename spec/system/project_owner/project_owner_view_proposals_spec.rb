require 'rails_helper'

describe 'Project owner view proposals' do
  it 'should view proposals from owned projects' do
    kurt = create(:project_owner)
    john = create(:project_owner)
    project = create(:project, project_owner: kurt, title: 'Desenvolvedor de Sites')
    other_project = create(:project, project_owner: john, title: 'Front on Fire')
    darth = create(:developer)
    create(:developer_profile, developer: darth)
    create(:proposal, project: project, developer: darth)
    create(:proposal, project: other_project, developer: darth)

    login_as kurt, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Proposta de Anakin Skywalker')
    expect(page).to have_link('Anakin Skywalker')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content(/40/)
    expect(page).to have_link('Aceitar Proposta')
    expect(page).to have_link('Recusar Proposta')
  end

  it 'and accept proposal' do
    kurt = create(:project_owner)
    project = create(:project, project_owner: kurt, title: 'Desenvolvedor de Sites')
    darth = create(:developer)
    create(:developer_profile, developer: darth)
    create(:proposal, project: project, developer: darth)

    login_as kurt, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Desenvolvedor de Sites'
    click_on 'Aceitar Proposta'

    expect(current_path).to eq(admin_project_path(project))
    expect(page).to have_content('Proposta aceita com sucesso!')
    expect(page).to have_content('Proposta de Anakin Skywalker')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content(/40/)
    expect(page).to have_content('Situação da Proposta: Aceita')
    expect(page).to have_link('Voltar', href: my_projects_admin_projects_path)
  end

  it 'and proposed refusal' do
    kurt = create(:project_owner)
    project = create(:project, project_owner: kurt, title: 'Desenvolvedor de Sites')
    bellamy = create(:developer)
    create(:developer_profile, developer: bellamy)
    create(:proposal, project: project, developer: bellamy)

    login_as kurt, scope: :project_owner
    visit my_projects_admin_projects_path
    click_on 'Desenvolvedor de Sites'
    click_on 'Recusar Proposta'

    expect(current_path).to eq(admin_project_path(project))
    expect(page).to have_content('Proposta recusada com sucesso!')
    expect(page).to have_content('Proposta de Anakin Skywalker')
    expect(page).to have_content('Motivação: Por pura diversão')
    expect(page).to have_content(/40/)
    expect(page).to have_content('Situação da Proposta: Recusada')
    expect(page).to have_link('Voltar', href: my_projects_admin_projects_path)
  end

  it 'must be logged in to view a proposal' do
    visit my_projects_admin_projects_path

    expect(current_path).to eq(new_project_owner_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end

  it 'except canceled' do
    kurt = create(:project_owner)
    project = create(:project, project_owner: kurt, title: 'Desenvolvedor de Sites')
    darth = create(:developer)
    create(:developer_profile, developer: darth)
    create(:proposal, project: project, developer: darth, status: :canceled)

    login_as kurt, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Desenvolvedor de Sites'

    expect(page).not_to have_content('Proposta de Anakin Skywalker')
    expect(page).not_to have_link('Anakin Skywalker')
    expect(page).not_to have_content('Motivação: Por pura diversão')
    expect(page).not_to have_content(/40/)
    expect(page).not_to have_button('Aceitar Proposta')
    expect(page).not_to have_button('Recusar Proposta')
  end
end
