require 'rails_helper'

describe 'Project Owner account management' do
  context 'log in' do
    it 'successfully' do
      teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

      visit root_path
      click_on 'Área do dono do projeto'
      fill_in 'Email', with: teu.email
      fill_in 'Senha', with: teu.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('Área do dono do projeto')
      expect(page).to have_content(teu.email)
      expect(page).to have_link('Sair')
      expect(page).not_to have_link('Área do dono do projeto')
      expect(page).to have_link('Cadastrar Projeto')
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
