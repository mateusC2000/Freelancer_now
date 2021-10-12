class User::ProfilesController < ApplicationController
  def my_profile
    @developer_profile = DeveloperProfile.find(params[:profile_id])
  end
end
