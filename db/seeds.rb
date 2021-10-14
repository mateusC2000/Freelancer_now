kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
    kproject = Project.create!({ title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                                 requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                                 maximum_value_per_hour: 10, end_date: '15/10/2021', working_model: 1, project_owner: kurt })
    
    john = ProjectOwner.create!(email: 'john@mmurphy.com.br', password: '1234567')
    jproject = Project.create!({ title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                                 requirements: 'Buscamos devs com experiência na área de front-end',
                                 maximum_value_per_hour: 25, end_date: '22/10/2021', working_model: 1, project_owner: john })

    bellamy = Developer.create!(email: 'bellamy@blake.com.br', password: '123456')
    DeveloperProfile.create!(full_name: 'Bellamy Blake', social_name: 'Bellamy', date_birth: '09/10/1985',
                             academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                             performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                             professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                             developer: bellamy)

    Proposal.create!({motivation: 'Por pura diversão', weekly_hours_available: 40,
                      project: kproject, developer: bellamy})

    Proposal.create!({motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                      weekly_hours_available: 40, project: jproject, developer: bellamy})
  p 'BANCO DE DADOS POPULADO COM SUCESSO!! :)'