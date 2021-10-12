class User::DevelopersController < ApplicationController
  def my_profile
    @developer_profile = DeveloperProfile.find(params[:id])
  end
end
