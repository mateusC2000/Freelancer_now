# require 'rails_helper'

# describe 'Developer filters projects by category' do
#   it 'using links on home page' do
#     ProjectCategory.create!(category: 'Front-end')
#     teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
#     kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
#     Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
#                     requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
#                     maximum_value_per_hour: 10, end_date: '30/12/2021', working_model: 1, project_category: 2,
#                     project_owner: teu)

#     Project.create!(title: 'Desenvolvedor de Aplicativos', description: 'Desenvolvimento de apps e-commerce e institucionais',
#                     requirements: 'Buscamos pessoas com experiência em e-commerce, JS, Java e C#',
#                     maximum_value_per_hour: 15, end_date: '20/12/2021', working_model: 2, project_category: 1,
#                     project_owner: kurt)
#     bellamy = Developer.create!(email: 'bellamy@blake', password: '123456')
#     DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
#                              academic_formation: 'Pós Graduado em Full Stack.',
#                              performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
#                              professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
#                              developer: bellamy)
#     login_as bellamy, scope: :developer
#     visit root_path
#     click_on 'Tipos de Projeto'
#     click on 'Back-end'

#     expect(page).to have_content('Desenvolvedor de Aplicativos')
#     expect(page).not_to have_content('Desenvolvedor de Sites')
#   end
# end