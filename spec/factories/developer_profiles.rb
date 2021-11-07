FactoryBot.define do
  factory :developer_profile do
    full_name { Faker::Movies::StarWars.character }
    social_name { full_name.split ' '.first }
    date_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    academic_formation { 'Graduado em Ciências da Tecnologia e Ciências de Dados.' }
    performance_zone { 'Sou desenvolvedor nas áreas de back-end e front-end.' }
    professional_experiences { 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.' }
    developer
  end
end
