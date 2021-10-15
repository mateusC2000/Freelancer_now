require 'rails_helper'

describe 'Project Owner authentication' do
  it 'cannot create projects without login' do
    post '/admin/projects', params: { project: { title: 'aaa' } }

    expect(response).to redirect_to(new_project_owner_session_path)
  end

  it 'cannot accept proposal without login' do
    post '/admin/proposals/1/accept', params: { proposal: { motivation: 'aaa' } }

    expect(response).to redirect_to(new_project_owner_session_path)
  end

  it 'cannot accept proposal without login' do
    post '/admin/proposals/1/recused', params: { proposal: { motivation: 'aaa' } }

    expect(response).to redirect_to(new_project_owner_session_path)
  end
end
