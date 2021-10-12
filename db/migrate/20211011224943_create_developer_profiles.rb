class CreateDeveloperProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :developer_profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :date_birth
      t.string :academic_formation
      t.string :performance_zone
      t.string :professional_experiences

      t.timestamps
    end
  end
end
