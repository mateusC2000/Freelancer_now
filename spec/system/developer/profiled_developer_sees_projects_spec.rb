require 'rails_helper'

describe 'Profiled developer sees projects ' do
  it 'successfully' do
    DeveloperProfile.create!(full_name: 'Anakin Skywalker', social_name: 'Anakin', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.')
    darth = Developer.create!(email: 'darth@vader.com.br', password: '123456789')
    login_as darth, scope: :developer
    visit root_path
    click_on 'Meu Perfil'

    expect(page).to have_content('Anakin Skywalker')
    expect(page).to have_content('Nome Social: Anakin')
    expect(page).to have_content('Data de Nascimento: 09/10/1985')
    expect(page).to have_content('Formação Acadêmica: Graduado em Ciências da Tecnologia e Ciências de Dados.')
    expect(page).to have_content('Zona de Atuação: Sou desenvolvedor nas áreas de back-end e front-end.')
    expect(page).to have_content('Experiências Profissionais: Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.')
    expect(page).to have_link('Voltar', href: root_path)
  end
end
