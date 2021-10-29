class ProjectsController < ApplicationController

  def search
    @projects = Project.where("title like '%#{params[:q]}%'")
  end
  
  def show
    @project = Project.find(params[:id])
  end
end