require 'rails_helper'

describe 'Developer account management' do
  context 'log in' do
    it 'successfully' do
      teu = Developer.create!(email: 'teu@shelby.com.br', password: '123456789')

      visit root_path
      click_on 'Área de desenvolvedores'
      fill_in 'Email', with: teu.email
      fill_in 'Senha', with: teu.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('Área de desenvolvedores')
      expect(page).to have_content(teu.email)
      expect(page).to have_link('Sair')
      expect(page).not_to have_link('Cadastrar Projeto')
    end

    it 'there can be no blank fields' do
      visit new_project_owner_session_path
      within 'form' do
        click_on 'Entrar'
      end
      expect(page).to have_content('Email ou senha inválida.')
    end
  end
end
