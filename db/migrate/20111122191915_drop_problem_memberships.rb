class DropProblemMemberships < ActiveRecord::Migration
  def change
    drop_table :problem_memberships
  end
end
