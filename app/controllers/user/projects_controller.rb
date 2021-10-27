class User::ProjectsController < DevelopersController

  def search
    @projects = Project.where("title like '%#{params[:q]}%'")
  end

  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
  end
end
