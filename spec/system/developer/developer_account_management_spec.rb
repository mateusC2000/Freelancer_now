require 'rails_helper'

describe 'Developer account management' do
  context 'log in' do
    it 'successfully' do
      teu = create(:developer)

      visit root_path
      click_on 'Área de desenvolvedores'
      fill_in 'Email', with: teu.email
      fill_in 'Senha', with: teu.password
      within 'div#login' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('Projetos Disponíveis')
      expect(page).to have_content('Área de desenvolvedores')
      expect(page).to have_content(teu.email)
      expect(page).to have_link('Sair')
      expect(page).not_to have_link('Cadastrar Projeto')
    end

    it 'and logs out' do
      teu = create(:developer)

      login_as teu, scope: :developer
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(page).to have_content('Projetos Disponíveis')
      expect(page).to_not have_content(teu.email)
      expect(page).to_not have_link('Sair')
      expect(page).to_not have_link('Cadastrar Imóvel')
    end

    it 'there can be no blank fields' do
      visit new_developer_session_path
      within 'div#login' do
        click_on 'Entrar'
      end
      expect(page).to have_content('Email ou senha inválida.')
    end
  end
end
