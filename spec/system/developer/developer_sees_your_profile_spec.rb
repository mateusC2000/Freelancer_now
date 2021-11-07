require 'rails_helper'

describe 'Developer sees your profile ' do
  it 'successfully' do
    darth = create(:developer)
    create(:developer_profile, developer: darth, full_name: 'Anakin Skywalker',
                               social_name: 'Anakin', date_birth: '09/10/1985',
                               academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                               performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                               professional_experiences: 'Experiências Profissionais: Já trabalhei em empresas como '\
                                                         'Millennium Falcon Code e TIE Avançado.')

    login_as darth, scope: :developer
    visit root_path
    click_on 'Meu Perfil'

    expect(page).to have_content('Anakin Skywalker')
    expect(page).to have_content('Nome Social: Anakin')
    expect(page).to have_content('Data de Nascimento: 09/10/1985')
    expect(page).to have_content('Formação Acadêmica: Graduado em Ciências da Tecnologia e Ciências de Dados.')
    expect(page).to have_content('Zona de Atuação: Sou desenvolvedor nas áreas de back-end e front-end.')
    expect(page).to have_content('Experiências Profissionais: Já trabalhei em empresas como '\
                                 'Millennium Falcon Code e TIE Avançado.')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and see only your own profile' do
    darth = create(:developer)
    create(:developer_profile, developer: darth, full_name: 'Anakin Skywalker')
    luke = create(:developer)
    create(:developer_profile, developer: luke, full_name: 'Luke Skywalker')

    login_as darth, scope: :developer
    visit root_path
    click_on 'Meu Perfil'

    expect(page).to have_content('Anakin Skywalker')
    expect(page).not_to have_content('Luke Skywalker')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'must see my profile button, if there is already registered profile' do
    darth = create(:developer)
    create(:developer_profile, developer: darth)

    login_as darth, scope: :developer
    visit root_path

    expect(page).not_to have_link('Completar Perfil')
    expect(page).to have_link('Meu Perfil')
  end

  it 'should see create profile button if there is no profile registered' do
    darth = create(:developer)

    login_as darth, scope: :developer
    visit root_path

    expect(page).to have_link('Completar Perfil')
    expect(page).not_to have_link('Meu Perfil')
  end

  it 'must be logged in to view own profile' do
    darth = create(:developer)
    profile = create(:developer_profile, developer: darth)

    visit user_developer_profile_path(profile)

    expect(current_path).to eq(new_developer_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
