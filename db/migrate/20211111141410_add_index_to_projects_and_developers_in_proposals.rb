class AddIndexToProjectsAndDevelopersInProposals < ActiveRecord::Migration[6.1]
  def change
    add_index :proposals, [:project_id, :developer_id], unique: true
  end
end
