require 'rails_helper'

describe 'Developer cancels the proposal made to the project' do
  it 'successfully' do
    joe = ProjectOwner.create!(email: 'joe@mmurphy.com.br', password: '1234567')
    project = Project.create!(title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                               requirements: 'Buscamos devs com experiência na área de front-end',
                               maximum_value_per_hour: 25, end_date: 5.days.from_now, working_model: 1, project_owner: joe)

    light = Developer.create!(email: 'light@yagami', password: '123456')
    DeveloperProfile.create!(full_name: 'Light Yagami', social_name: 'Light', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: light)

    Proposal.create!(motivation: 'Por pura diversão', weekly_hours_available: 20,
                     project: project, developer: light, status: :pending)

    login_as light, scope: :developer
    visit root_path
    click_on 'Minhas Propostas'
    click_on 'Front on Fire'
    click_on 'Cancelar Proposta'

    expect(page).to have_content('Proposta cancelada com sucesso!')
    expect(page).to have_content('Situação da Proposta: Cancelada')

  end
end
