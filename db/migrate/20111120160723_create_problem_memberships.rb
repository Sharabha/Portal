class CreateProblemMemberships < ActiveRecord::Migration
  def change
    create_table :problem_memberships do |t|
      t.integer :problem_id
      t.integer :competition_id

      t.timestamps
    end
  end
end
