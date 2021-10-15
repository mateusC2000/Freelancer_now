class Project < ApplicationRecord
  belongs_to :project_owner
  has_many :proposals
  
  enum working_model: { presential: 1, remote: 2 }

  validates :title, :description, :requirements,
            :maximum_value_per_hour, :end_date,
            :working_model, presence: true

  validates :maximum_value_per_hour, numericality: { greater_than: 0 }

  validate :end_date_in_the_future

  private

  def end_date_in_the_future
    unless end_date.nil?
      if end_date < Date.today
        errors.add(:end_date, I18n.t('.errors.invalid_date'))
      end
    end
  end
end
