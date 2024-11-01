require 'rails_helper'

describe 'project API' do
  context 'GET /api/v1/projects' do
    it 'should get projects' do
      dev = create(:developer)
      pj = create(:project, title: 'Desenvolvimento de Apps')
      create(:project, title: 'Desenvolvimento de Sites')
      create(:proposal, project: pj, developer: dev)
      token = JWT.encode(dev.email, ENV.fetch('JWT_SECRET', nil))

      get '/api/v1/projects', headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(parsed_body.first[:title]).to eq('Desenvolvimento de Apps')
      expect(parsed_body.first[:proposals].first[:developer]).to eq({ email: dev.email })
      expect(parsed_body.second[:proposals]).to eq([])
      expect(parsed_body.second[:title]).to eq('Desenvolvimento de Sites')
      expect(parsed_body.count).to eq(2)
    end

    it 'should get projects' do
      create(:project, title: 'Desenvolvimento de Apps')
      create(:project, title: 'Desenvolvimento de Sites')

      get '/api/v1/projects'
      expect(response).to have_http_status(401)
      expect(parsed_body[:title]).not_to eq('Desenvolvimento de Apps')
      expect(parsed_body[:title]).not_to eq('Desenvolvimento de Sites')
      expect(parsed_body[:message]).to eq('Por favor, faça login.')
    end

    it 'returns no projects' do
      dev = create(:developer)
      token = JWT.encode(dev.email, ENV.fetch('JWT_SECRET', nil))

      get '/api/v1/projects', headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/projects/:id' do
    it 'should return a project' do
      dev = create(:developer)
      project = create(:project, title: 'Desenvolvendo Back e Front',
                                 description: 'Lê o título.',
                                 requirements: 'Saber back e front',
                                 maximum_value_per_hour: 40,
                                 working_model: 1)
      token = JWT.encode(dev.email, ENV.fetch('JWT_SECRET', nil))

      get "/api/v1/projects/#{project.id}", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:title]).to eq('Desenvolvendo Back e Front')
      expect(parsed_body[:description]).to eq('Lê o título.')
      expect(parsed_body[:requirements]).to eq('Saber back e front')
      expect(parsed_body[:maximum_value_per_hour]).to eq('40.0')
    end

    it 'must be logged in' do
      project = create(:project, title: 'Desenvolvendo Back e Front',
                                 description: 'Lê o título.',
                                 requirements: 'Saber back e front',
                                 maximum_value_per_hour: 40,
                                 working_model: 1)

      get "/api/v1/projects/#{project.id}"

      expect(response).to have_http_status(401)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:message]).to eq('Por favor, faça login.')
    end

    it 'should return 404 if project does not exist' do
      get '/api/v1/projects/999'

      expect(response).to have_http_status(401)
      expect(parsed_body[:message]).to eq('Por favor, faça login.')
    end

    it 'should return 404 if project does not exist' do
      dev = create(:developer)
      token = JWT.encode(dev.email, ENV.fetch('JWT_SECRET', nil))

      get '/api/v1/projects/999', headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq('Objeto não encontrado')
    end

    it 'should return 500 if database is not available' do
      dev = create(:developer)
      project = create(:project, title: 'Desenvolvendo Back e Front',
                                 description: 'Lê o título.',
                                 requirements: 'Saber back e front',
                                 maximum_value_per_hour: 40,
                                 working_model: 1)
      token = JWT.encode(dev.email, ENV.fetch('JWT_SECRET', nil))

      allow(Project).to receive(:find).with(project.id.to_s).and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/projects/#{project.id}", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(500)
    end
  end

  context 'POST api/v1/projects' do
    it 'should save a new project' do
      project_category = FactoryBot.create(:project_category)
      project_owner = FactoryBot.create(:project_owner)

      project_params = { project: { title: 'Desenvolvendo Back e Front', description: 'Lê o título.',
                                    requirements: 'Saber back e front', maximum_value_per_hour: 40,
                                    working_model: 'remote', end_date: 1.day.from_now,
                                    project_owner_id: project_owner.id,
                                    project_category_id: project_category.id } }

      post '/api/v1/projects', params: project_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:id]).to eq(Project.last.id)
      expect(parsed_body[:title]).to eq('Desenvolvendo Back e Front')
      expect(parsed_body[:description]).to eq('Lê o título.')
      expect(parsed_body[:requirements]).to eq('Saber back e front')
      expect(parsed_body[:maximum_value_per_hour]).to eq('40.0')
      expect(parsed_body[:working_model]).to eq('remote')
    end
  end
  context 'POST api/v1/login' do
    it 'sucessfully' do
      dev = create(:developer, email: 'jane.doe@gmail.com', password: '123456789')
      post '/api/v1/login', params: { email: 'jane.doe@gmail.com', password: '123456789' }

      expect(response).to have_http_status(202)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:message]).to eq("Bem-vindo #{dev.email}")
    end

    it 'and there can be no blank fields' do
      create(:developer, email: 'jane.doe@gmail.com', password: '123456789')
      post '/api/v1/login', params: { email: '', password: '123456789' }

      expect(response).to have_http_status(401)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:message]).to eq('Email ou senha inválida')
    end
    it 'and there can be no blank fields' do
      create(:developer, email: 'jane.doe@gmail.com', password: '123456789')
      post '/api/v1/login', params: { email: 'jane.doe@gmail.com', password: '' }

      expect(response).to have_http_status(401)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:message]).to eq('Email ou senha inválida')
    end
  end
end
