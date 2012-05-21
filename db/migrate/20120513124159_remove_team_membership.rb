class RemoveTeamMembership < ActiveRecord::Migration
  def up
    drop_table :team_memberships
    rename_column :solutions, :team_membership_id, :team_id
    add_column :teams, :competition_id, :integer
  end

  def down
    remove_column :teams, :competition_id
    rename_column :solutions, :team_id, :team_membership_id
    create_table :team_memberships do |t|
      t.integer  :team_id
      t.integer  :competition_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
