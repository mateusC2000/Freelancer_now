class Admin::ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to [:admin, @project]
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :requirements,
                                    :maximum_value_per_hour, :end_date,
                                    :working_model)
  end
end