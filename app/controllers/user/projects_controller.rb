class User::ProjectsController < DevelopersController

  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
  end
end
