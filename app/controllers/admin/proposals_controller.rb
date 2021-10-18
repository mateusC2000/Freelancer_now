class Admin::ProposalsController < ProjectOwnersController
  before_action :set_proposal

  def accept
    @proposal.accepted!
    redirect_to [:admin, @proposal.project], notice: 'Proposta aceita com sucesso!'
  end

  def recused
    @proposal.recused!
    redirect_to [:admin, @proposal.project], notice: 'Proposta recusada com sucesso!'
  end

  private
  
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
