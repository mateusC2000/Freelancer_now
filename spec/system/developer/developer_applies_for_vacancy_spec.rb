require 'rails_helper'

describe 'Developer applies for vacancy' do
  it 'successfully' do
    create(:project, title: 'Desenvolvedor de Sites')
    darth = create(:developer)
    create(:developer_profile, developer: darth)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Ver Informações do Projeto'
    fill_in 'Motivação',
            with: 'Tenho experiencia na área de desenvolvimento e pretendo focar '\
                  'minha carreira apenas nisso, além de ter gostado da proposta'
    fill_in 'Horas Semanais Disponíveis', with: 40
    click_on 'Candidate-se'

    expect(page).to have_content('Proposta enviada com sucesso!')
    expect(page).to have_content('Avaliaremos seu perfil e em breve retornaremos uma resposta.')
    expect(page).to have_content('Motivação: Tenho experiencia na área de desenvolvimento e pretendo focar minha '\
                                 'carreira apenas nisso, além de ter gostado da proposta')
    expect(page).to have_content('Horas Semanais Disponíveis: 40')
    expect(page).to have_content("Proposta enviada em: #{I18n.l(Proposal.last.created_at, format: :long)}")
    expect(page).to have_content('Situação da Proposta: Pendente')
  end

  it 'and there should be no blank fields' do
    create(:project, title: 'Desenvolvedor de Sites')
    darth = create(:developer)
    create(:developer_profile, developer: darth)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Ver Informações do Projeto'
    click_on 'Candidate-se'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'unsuccessful due to lack of profile' do
    create(:project, title: 'Desenvolvedor de Sites')
    darth = create(:developer)

    login_as darth, scope: :developer
    visit root_path
    click_on 'Ver Informações do Projeto'

    expect(page).to have_link('Complete seu perfil para candidatar-se a vaga.')
  end
end
