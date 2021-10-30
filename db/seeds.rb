back_end = ProjectCategory.create!(category: 'Back-end')
front_end = ProjectCategory.create!(category: 'Front-end')
back_front = ProjectCategory.create!(category: 'Back-end e Front-end')

kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
prime_tech = Project.create!(title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                             requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                             maximum_value_per_hour: 50, end_date: 10.days.from_now, working_model: 1,
                             project_category: back_end, project_owner: kurt)
Project.create!(title: 'Site e Aplicativo para pet shop',
                description: 'App se resume em: cliente agenda o serviço e o motorista recebe a notificação da corrida para buscar o pet,',
                requirements: 'Conhecimento na área de wordpress, android e IOS.',
                maximum_value_per_hour: 15, end_date: 10.days.from_now, working_model: 1,
                project_category: back_front, project_owner: kurt)
Project.create!(title: 'Criação de site e integração com API Xpax',
                description: 'Preciso criar um site de tênis a varejo e em atacado, e preciso que ele tenha integração com a xpax',
                requirements: 'Conhecimento em back-end, dados e API.',
                maximum_value_per_hour: 45, end_date: 10.days.from_now, working_model: 2,
                project_category: back_end, project_owner: kurt)

jane = ProjectOwner.create!(email: 'jane@doe.com.br', password: '123456789')
techno_trend = Project.create!(title: 'Front on Fire', description: 'Aprimoramento de site de imóveis com front-end',
                               requirements: 'Buscamos devs com experiência na área de front-end',
                               maximum_value_per_hour: 25, end_date: 10.days.from_now, working_model: 1,
                               project_category: front_end, project_owner: jane)
Project.create!(title: 'Desenvolvimento de PWA', description: 'Nossa startup está em busca de um desenvolvedor para dar vida ao nosso protótipo.',
                requirements: 'Familiaridade em criar Aplicações Web, com conhecimento de HTML, CSS, Bootstrap, Firebase e React.',
                maximum_value_per_hour: 50, end_date: 10.days.from_now, working_model: 2,
                project_category: back_front, project_owner: jane)
Project.create!(title: 'Manutenção site Wordpress', description: 'Na opção buscar preciso que ao escolher a cidade, carregar os bairros disponíveis',
                requirements: 'Conhecimento básico em back-end',
                maximum_value_per_hour: 10, end_date: 10.days.from_now, working_model: 2,
                project_category: back_end, project_owner: jane)

ryan = ProjectOwner.create!(email: 'ryan@kaen.com.br', password: '123456789')
Project.create!(title: 'Opencart Saas', description: 'Utilizar o OpenCart e transformar em um SaaS',
                requirements: 'Conhecimento em JS, PHP e API.',
                maximum_value_per_hour: 35, end_date: 10.days.from_now, working_model: 2,
                project_category: back_end, project_owner: ryan)
Project.create!(title: 'Reprogramar área de cliente e adicionar novas funcionalidades',
                description: 'Já temos essa área cliente em funcionamento, mas decidimos refaze-la e adicionar novas funcionalidades',
                requirements: 'Conhecimento em SQL Server, PHP, JavaScript, HTML, CSS, Front End, Bootstrap/Material UI',
                maximum_value_per_hour: 80, end_date: 10.days.from_now, working_model: 2,
                project_category: back_front, project_owner: ryan)
Project.create!(title: 'Desenvolvedor para sites de diversos segmentos',
                description: 'Tenho muitas demandas de sites e landing pages e procuro um parceiro para passar essas demandas recorrentes.',
                requirements: 'Conhecimento em wordpress',
                maximum_value_per_hour: 20, end_date: 10.days.from_now, working_model: 2,
                project_category: front_end, project_owner: ryan)

anjel = ProjectOwner.create!(email: 'anjel@julian.com.br', password: '123456789')
Project.create!(title: 'Página web principal para empresa de conteúdo educacional',
                description: 'Gostaríamos de um desenvolvedor de website para construir nossa segunda versão do website da empresa EducationalTech',
                requirements: 'Conhecimento em wordpress/elementor',
                maximum_value_per_hour: 15, end_date: 10.days.from_now, working_model: 1,
                project_category: back_front, project_owner: anjel)
Project.create!(title: 'Desenvolvedor - Full Stack',
                description: 'Solicito desenvolvedor full stack para desenvolvimento de uma plataforma',
                requirements: 'Conhecimento em back end e front end.',
                maximum_value_per_hour: 35, end_date: 10.days.from_now, working_model: 2,
                project_category: back_front, project_owner: anjel)

chris = ProjectOwner.create!(email: 'chris@rock.com.br', password: '123456789')
Project.create!(title: 'Criação de App Android',
                description: 'A ideia é desenvolver um aplicativo baseado no que já existe no mercado em monitoramento de celular/android',
                requirements: 'Conhecimento em Ciência de Dados, Java e JS.',
                maximum_value_per_hour: 15, end_date: 10.days.from_now, working_model: 1,
                project_category: back_front, project_owner: chris)
Project.create!(title: 'Desenvolvedor Flutter para Android, IOS, Desktop e web',
                description: 'Procuro desenvolvedor para projeto rápido em Flutter para Android, iOS, Desktop e Web e na utilização de API RESTful.',
                requirements: 'Com experiência com Dart, conhecimento em boas práticas como MVVM ou BloC, conhecimento em versionamento com Git.',
                maximum_value_per_hour: 75, end_date: 10.days.from_now, working_model: 2,
                project_category: back_front, project_owner: chris)

darth = Developer.create!(email: 'darth@vader.com.br', password: '123456789')
profile = DeveloperProfile.create!(full_name: 'Anakin Skywalker', social_name: 'Anakin', date_birth: '09/10/1985',
                         academic_formation: 'Graduado em Ciências da Tecnologia e Ciências de Dados.',
                         performance_zone: 'Sou desenvolvedor nas áreas de back-end e front-end.',
                         professional_experiences: 'Já trabalhei em empresas como Millennium Falcon Code e TIE Avançado.',
                         developer: darth)
profile.image.attach(io: File.open('spec/images/darth.jpg'), filename: 'darth.jpg')

Proposal.create!(motivation: 'Por pura diversão', weekly_hours_available: 40,
                 project: prime_tech, developer: darth)

Proposal.create!(motivation: 'Trabalhei na área por muito tempo e quero voltar a ativa.',
                 weekly_hours_available: 40, project: techno_trend, developer: darth)
p 'BANCO DE DADOS POPULADO COM SUCESSO!! :)'
