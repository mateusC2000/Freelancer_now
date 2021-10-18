kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
prime_tech = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                             requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                             maximum_value_per_hour: 50, end_date: 10.days.from_now, working_model: 1, project_owner: kurt)

jane = ProjectOwner.create!(email: 'jane@doe.com.br', password: '1234567')
techno_trend = Project.create!(title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                               requirements: 'Buscamos devs com experiência na área de front-end',
                               maximum_value_per_hour: 25, end_date: 10.days.from_now, working_model: 1, project_owner: jane)

darth = Developer.create!(email: 'darth@vader.com.br', password: '123456789')
DeveloperProfile.create!(full_name: 'Anakin Skywalker', social_name: 'Anakin', date_birth: '09/10/1985',
                         academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                         performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                         professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                         developer: darth)

Proposal.create!(motivation: 'Por pura diversão', weekly_hours_available: 40,
                 project: prime_tech, developer: darth)

Proposal.create!(motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                 weekly_hours_available: 40, project: techno_trend, developer: darth)
p 'BANCO DE DADOS POPULADO COM SUCESSO!! :)'
