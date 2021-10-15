class User::ProposalsController < ApplicationController
  before_action :set_project, only: %i[create show index]

  def index
    @proposals = current_developer.proposals
  end

  def create
    @proposal = current_developer.proposals.new(proposal_params)
    @proposal.project = @project
    if @proposal.save
      redirect_to [:user, @project, @proposal], notice: t('.success')
    else
      render 'user/projects/show'
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  private

  def proposal_params
    params.require(:proposal).permit(:motivation, :weekly_hours_available)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
