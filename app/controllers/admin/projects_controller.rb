class Admin::ProjectsController < ProjectOwnersController
  before_action :set_project, only: %i[show edit update]

  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    @project.project_owner = current_project_owner
    if @project.save
      redirect_to [:admin, @project]
    else
      render :new
    end
  end

  def show
  end

  def my_projects
    @projects = current_project_owner.projects
  end
  
  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to [:admin, @project], notice: t('.success')
    else
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :requirements,
                                    :maximum_value_per_hour, :end_date,
                                    :working_model)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
