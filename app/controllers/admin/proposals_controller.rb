class Admin::ProposalsController < ApplicationController
  def accept
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    redirect_to [:admin, @proposal.project], notice: 'Proposta aceita com sucesso!'
  end
end
