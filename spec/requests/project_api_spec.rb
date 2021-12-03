require 'rails_helper'

describe 'project API' do
  context 'GET /api/v1/projects' do
    it 'should get projects' do
      create(:project, title: 'Desenvolvimento de Apps')
      create(:project, title: 'Desenvolvimento de Sites')

      get '/api/v1/projects'

      expect(response).to have_http_status(200)
      expect(parsed_body.first[:title]).to eq('Desenvolvimento de Apps')
      expect(parsed_body.second[:title]).to eq('Desenvolvimento de Sites')
      expect(parsed_body.count).to eq(2)
    end

    it 'returns no projects' do
      get '/api/v1/projects'

      expect(response).to have_http_status(200)
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/projects/:id' do
    it 'should return a project' do
      project = create(:project, title: 'Desenvolvendo Back e Front',
                                 description: 'Lê o título.',
                                 requirements: 'Saber back e front',
                                 maximum_value_per_hour: 40,
                                 working_model: 1)

      get "/api/v1/projects/#{project.id}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:title]).to eq('Desenvolvendo Back e Front')
      expect(parsed_body[:description]).to eq('Lê o título.')
      expect(parsed_body[:requirements]).to eq('Saber back e front')
      expect(parsed_body[:maximum_value_per_hour]).to eq('40.0')
    end

    it 'should return 404 if project does not exist' do
      get '/api/v1/projects/999'

      expect(response).to have_http_status(404)
    end

    it 'should return 500 if database is not available' do
      project = create(:project, title: 'Desenvolvendo Back e Front',
                                 description: 'Lê o título.',
                                 requirements: 'Saber back e front',
                                 maximum_value_per_hour: 40,
                                 working_model: 1)

      allow(Project).to receive(:find).with(project.id.to_s).and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/projects/#{project.id}"

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
end
