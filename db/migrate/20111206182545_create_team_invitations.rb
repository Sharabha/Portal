class CreateTeamInvitations < ActiveRecord::Migration
  def change
    create_table :team_invitations do |t|
      t.integer :user_id
      t.integer :team_id
      t.boolean :confirmed

      t.timestamps
    end
  end
end
