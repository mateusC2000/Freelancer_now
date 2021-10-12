# require 'rails_helper'

# describe 'Developer creates profile' do
#   it 'successfully' do
#     joao = Developer.create!(email: 'jbaptist@fields.com.br', password: '123456789')

#     login_as teu, scope: :developer
#     visit root_path
#     click_on 'Completar Perfil'

#     fill_in 'Nome completo', with: 'João Batista Campos'
#     fill_in 'Nome social', with: 'João'
#     fill_in 'Data de Nascimento', with: '19/10/1920'
#     fill_in 'Formação Acadêmica', with: 'Pós Graduado em Full Stack.'
#     fill_in 'Zona de Atuação', with: 'Sou desenvolvedor nas áreas de back-end e front-end.'
#     fill_in 'Experiências profissionais', with: 'Participação na turma 5 do Treinadev, e estágio em parceiras.'
#     fill_in 'Caontato', with: 'jbaptist@fields.com.br'
#     click_on 'Atualizar perfil'

#     expect.to have_content('João Batista Campos')
#     expect.to have_content('João')
#     expect.to have_content('19/10/1920')
#     expect.to have_content('Pós Graduado em Full Stack.')
#     expect.to have_content('Sou desenvolvedor nas áreas de back-end e front-end.')
#     expect.to have_content('Participação na turma 5 do Treinadev, e estágio em parceiras.')
#     expect.to have_content('jbaptist@fields.com.br')
#   end
# end
