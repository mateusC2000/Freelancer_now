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
  end
end
