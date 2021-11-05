class Project < ApplicationRecord
  belongs_to :project_owner
  has_many :proposals, dependent: :destroy
  belongs_to :project_category

  enum working_model: { presential: 1, remote: 2 }

  validates :title, :description, :requirements,
            :maximum_value_per_hour, :end_date,
            :working_model, presence: true

  validates :maximum_value_per_hour, numericality: { greater_than: 0 }

  validate :end_date_in_the_future

  private

  def end_date_in_the_future
    errors.add(:end_date, I18n.t('.errors.invalid_date')) if !end_date.nil? && (end_date < Time.zone.today)
  end
end
