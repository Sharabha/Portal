class GuardianMembership < ActiveRecord::Migration
  def change
    create_table :guardian_memberships do |t|
      t.integer :guardian_id
      t.integer :problem_membership_id

      t.timestamps
    end
  end
end
