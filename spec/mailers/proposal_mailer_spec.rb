require 'rails_helper'

RSpec.describe ProposalMailer, type: :mailer do
  context 'new proposal' do
    it 'should notify project owner' do
      back = create(:project_category, category: 'Back-end')
      john = create(:project_owner, email: 'john@doe.com.br', password: '123456')
      project = Project.create!(title: 'ADs', description: 'B', requirements: 'C',
                                maximum_value_per_hour: 40, end_date: 1.week.from_now,
                                working_model: 1, project_category: back, project_owner: john)
      darth = create(:developer, email: 'darth@vader.com.br', password: '123456789')

      proposal = create(:proposal, project: project, developer: darth)

      mail = ProposalMailer.with(proposal: proposal).notify_new_proposal

      expect(mail.to).to eq [john.email.to_s]
      expect(mail.from).to eq ['nao-responda@flats.com.br']
      expect(mail.subject).to eq 'Nova proposta para seu projeto'
      expect(mail.body).to include 'Você recebeu uma proposta de darth@vader.com.br no seu projeto ADs'
    end
  end
end
