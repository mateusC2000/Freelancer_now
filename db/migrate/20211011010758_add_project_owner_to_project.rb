class AddProjectOwnerToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :project_owner, null: false, foreign_key: true
  end
end
