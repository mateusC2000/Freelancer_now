class Api::V1::ProjectsController < ActionController::API
  def index
    @projects = Project.all
    render json: @projects.as_json(except: %i[created_at updated_at project_category_id],
                                   include: { project_category: { only: %i[name] } })
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end
end
