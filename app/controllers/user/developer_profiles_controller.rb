class User::DeveloperProfilesController < ApplicationController
  before_action :authenticate_developer!

  def show
    @developer_profile = DeveloperProfile.find(params[:id])
  end

  def new
    @developer_profile = DeveloperProfile.new
  end

  def create
    @developer_profile = DeveloperProfile.new(profile_params)
    @developer_profile.developer = current_developer
    if @developer_profile.save
      redirect_to [:user, @developer_profile], notice: 'Perfil atualizado com sucesso!'
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:developer_profile).permit(:full_name, :social_name, :date_birth,
                                              :academic_formation, :performance_zone,
                                              :professional_experiences)
  end
end
