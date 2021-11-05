FactoryBot.define do
  factory :developer_profile do
    full_name { 'Anakin Skywalker' }
    social_name { 'Anakin' }
    date_birth { '09/10/1985' }
    academic_formation { 'Graduado em Ciências da Tecnologia e Ciências de Dados.' }
    performance_zone { 'Sou desenvolvedor nas áreas de back-end e front-end.' }
    professional_experiences { 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.' }
    developer
  end
end
