class ProposalMailer < ApplicationMailer
  def notify_new_proposal
    @proposal = params[:proposal]
    @project_owner =  @proposal.project.project_owner
    mail(to: @project_owner.email,
         subject: "Nova proposta para seu projeto")
  end
end
