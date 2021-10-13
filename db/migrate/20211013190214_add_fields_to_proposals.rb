class AddFieldsToProposals < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :motivation, :string
    add_column :proposals, :weekly_hours_available, :integer
  end
end
