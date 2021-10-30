require 'rails_helper'

describe 'Developer edits profile' do
  it 'successfully' do
    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Pós Graduado em Full Stack.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Meu Perfil'
    click_on 'Editar Perfil'

    fill_in 'Nome Completo', with: 'Bellamy Blake'
    fill_in 'Nome Social', with: 'Bell'
    fill_in 'Data de Nascimento', with: '09/10/1985'
    fill_in 'Formação Acadêmica', with: 'Pós Graduado em Full Stack e Graduado em Ciências de Dados.'
    fill_in 'Zona de Atuação', with: 'Sou desenvolvedor nas áreas de back-end e front-end.'
    fill_in 'Experiências Profissionais',
            with: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado e na MarketCode.'
    click_on 'Atualizar Perfil'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Bellamy Blake')
    expect(page).to have_content('Bell')
    expect(page).to have_content('09/10/1985')
    expect(page).to have_content('Pós Graduado em Full Stack e Graduado em Ciências de Dados.')
    expect(page).to have_content('Sou desenvolvedor nas áreas de back-end e front-end.')
    expect(page).to have_content('Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado e na MarketCode.')
  end

  it 'and there should be no blank fields' do
    bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Pós Graduado em Full Stack.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    login_as bellamy, scope: :developer
    visit root_path
    click_on 'Meu Perfil'
    click_on 'Editar Perfil'

    fill_in 'Nome Completo', with: ''
    fill_in 'Nome Social', with: ''
    fill_in 'Data de Nascimento', with: ''
    fill_in 'Formação Acadêmica', with: ''
    fill_in 'Zona de Atuação', with: ''
    fill_in 'Experiências Profissionais', with: ''
    click_on 'Atualizar Perfil'

    expect(page).to have_content('não pode ficar em branco', count: 6)
  end
end
