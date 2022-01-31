require 'rails_helper'

RSpec.describe NotifyProposalMailerJob, type: :job do
  it "should respond to #perform" do
    expect(NotifyProposalMailerJob.new).to respond_to(:perform)
  end

  describe 'NotifyProposalMailerJob' do
    before do
        Sidekiq::Extensions.enable_delay!
        Sidekiq::Worker.clear_all
    end

    it 'should enqueue a Email job' do
      proposal = create(:proposal)

      row = JSON.generate({ proposal_id: proposal.id})

      assert_equal 0, Sidekiq::Queues["default"].size
      NotifyProposalMailerJob.perform_async(row, 1)
      assert_equal 1, Sidekiq::Queues["default"].size
    end
  end
end