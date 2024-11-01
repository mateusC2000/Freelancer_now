class ProposalMailer < ApplicationMailer
  def notify_new_proposal
    @proposal = Proposal.find(params[:proposal])
    @project_owner = @proposal.project.project_owner
    mail(to: @project_owner.email,
         subject: t('mailer.new_proposal_subject'))
  end
end
