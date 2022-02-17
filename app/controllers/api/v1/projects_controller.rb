class Api::V1::ProjectsController < Api::V1::ApiController
  before_action :require_login, only: %i[index show]

  def index
    projects = Project.all
    render json: projects, each_serializer: ProjectSerializer
  end

  def show
    project = Project.find(params[:id])
    render json: project, serializer: ProjectSerializer
  end

  def create
    @project = Project.create(project_params)
    render status: :created, json: @project
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :requirements,
                                    :maximum_value_per_hour, :end_date,
                                    :working_model, :project_category_id, :project_owner_id)
  end
end
