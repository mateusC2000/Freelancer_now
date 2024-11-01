require 'rails_helper'

describe 'Project owner view developer candidate profile' do
  it 'successfully' do
    kurt = create(:project_owner)
    project = create(:project, project_owner: kurt, title: 'Desenvolvedor de Sites')
    bellamy = create(:developer)
    profile = create(:developer_profile, developer: bellamy, full_name: 'Bellamy Blake',
                                         social_name: 'Bellamy', date_birth: '09/10/1985',
                                         academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                                         performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                                         professional_experiences: 'Já trabalhei em empresas como Millennium ' \
                                                                   'Falcon Code e TIE Avançado.')

    profile.image.attach(io: File.open('spec/images/profile.png'), filename: 'profile.png')
    create(:proposal, project: project, developer: bellamy)

    login_as kurt, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'
    click_on 'Ver Detalhes'
    click_on 'Bellamy Blake'

    expect(page).to have_css('img[src*="profile.png"]')
    expect(page).to have_content('Perfil do Candidato')
    expect(page).to have_content('Bellamy Blake')
    expect(page).to have_content('Bellamy')
    expect(page).to have_content('09/10/1985')
    expect(page).to have_content('Graduado em Ciências da Tecnologia e Ciências de Dados.')
    expect(page).to have_content('Sou desenvolvedor nas áreas de back-end e front-end.')
    expect(page).to have_content('Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.')
    expect(page).to have_link('Voltar')
  end
end
