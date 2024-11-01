class Admin::ProposalsController < ProjectOwnersController
  before_action :set_proposal

  def accept
    @proposal.accepted!
    redirect_to [:admin, @proposal.project], notice: t('.proposal_accepted')
  end

  def recused
    @proposal.recused!
    redirect_to [:admin, @proposal.project], notice: t('.proposal_rejected')
  end

  def candidate_profile
    @project = Project.find(params[:id])
    @candidate_profile = @proposal.developer.developer_profile
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
