class AddProjectCategoryToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :project_category, null: false, foreign_key: true
  end
end
