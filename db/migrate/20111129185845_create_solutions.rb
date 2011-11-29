class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :team_membership_id
      t.integer :problem_membership_id
      t.string :code_file_name
      t.string :code_content_type
      t.integer :code_file_size
      t.datetime :code_updated_at
      t.text :description

      t.timestamps
    end
  end
end
