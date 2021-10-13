teu = ProjectOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
kurt = ProjectOwner.create!(email: 'kurt@weler.com.br', password: '123456789')
Project.create!({ title: 'Desenvolvedor de Sites', description: 'Desenvolvimento de sites e-commerce e institucionais',
                  requirements: 'Buscamos pessoas com experiência em e-commerce, Google ADS CMS SEO',
                  maximum_value_per_hour: 10, end_date: '15/10/2021', working_model: 1, project_owner: teu })
Project.create!({ title: 'Desenvolvedor de Aplicativos', description: 'Desenvolvimento de apps e-commerce e institucionais',
                  requirements: 'Buscamos pessoas com experiência em e-commerce, JS, Java e C#',
                  maximum_value_per_hour: 15, end_date: '20/10/2021', working_model: 2, project_owner: kurt })
