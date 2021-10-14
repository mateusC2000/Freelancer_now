class Admin::ProposalsController < ApplicationController
  def accept
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    redirect_to [:admin, @proposal.project], notice: 'Proposta aceita com sucesso!'
  end
  def recused
    @proposal = Proposal.find(params[:id])
    @proposal.recused!
    redirect_to [:admin, @proposal.project], notice: 'Proposta recusada com sucesso!'
  end
end
