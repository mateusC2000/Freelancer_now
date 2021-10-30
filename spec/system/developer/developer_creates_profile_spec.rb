require 'rails_helper'

describe 'Developer creates profile' do
  it 'successfully' do
    joao = Developer.create!(email: 'jbaptist@fields.com.br', password: '123456789')

    login_as joao, scope: :developer
    visit root_path
    click_on 'Completar Perfil'

    fill_in 'Nome Completo', with: 'João Batista Campos'
    fill_in 'Nome Social', with: 'João'
    fill_in 'Data de Nascimento', with: '19/10/1920'
    fill_in 'Formação Acadêmica', with: 'Pós Graduado em Full Stack.'
    fill_in 'Zona de Atuação', with: 'Sou desenvolvedor nas áreas de back-end e front-end.'
    fill_in 'Experiências Profissionais', with: 'Participação na turma 5 do Treinadev, e estágio em parceiras.'
    attach_file 'Foto de Perfil', Rails.root.join('spec/images/profile.png')
    click_on 'Criar Perfil'

    expect(page).to have_css('img[src*="profile.png"]')
    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('João Batista Campos')
    expect(page).to have_content('João')
    expect(page).to have_content('19/10/1920')
    expect(page).to have_content('Pós Graduado em Full Stack.')
    expect(page).to have_content('Sou desenvolvedor nas áreas de back-end e front-end.')
    expect(page).to have_content('Participação na turma 5 do Treinadev, e estágio em parceiras.')
  end

  it 'and there should be no blank fields' do
    joao = Developer.create!(email: 'joao@shelby.com.br', password: '123456789')

    login_as joao, scope: :developer
    visit new_user_developer_profile_path
    click_on 'Criar Perfil'

    expect(page).to have_content('não pode ficar em branco', count: 6)
  end

  it 'must be logged in to creates a profile' do
    visit new_user_developer_profile_path

    expect(current_path).to eq(new_developer_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end
