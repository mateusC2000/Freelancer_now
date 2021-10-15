require 'rails_helper'

describe 'Developer authentication' do
  it 'cannot create profile without login' do
    post '/user/developer_profiles', params: { developer_profile: { full_name: 'aaa' } }

    expect(response).to redirect_to( new_developer_session_path)
  end

  it 'cannot create profile without login' do
    post '/user/projects/1/proposals', params: { proposals: { motivation: 'aaa' } }

    expect(response).to redirect_to( new_developer_session_path)
  end

end
