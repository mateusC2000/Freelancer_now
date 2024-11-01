class User::DeveloperProfilesController < DevelopersController
  before_action :set_developer_profile, only: %i[show edit update]

  def show; end

  def new
    @developer_profile = DeveloperProfile.new
  end

  def edit; end

  def create
    @developer_profile = DeveloperProfile.new(profile_params)
    @developer_profile.developer = current_developer
    if @developer_profile.save
      redirect_to [:user, @developer_profile], notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @developer_profile.update(profile_params)
      redirect_to [:user, @developer_profile], notice: t('.success')
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:developer_profile).permit(:full_name, :social_name, :date_birth,
                                              :academic_formation, :performance_zone,
                                              :professional_experiences, :image)
  end

  def set_developer_profile
    @developer_profile = DeveloperProfile.find(params[:id])
  end
end
