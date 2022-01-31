class NotifyProposalMailerJob
  include Sidekiq::Job
  def perform(proposal)
    ProposalMailer.with(proposal: proposal).notify_new_proposal.deliver_now
  end
end
