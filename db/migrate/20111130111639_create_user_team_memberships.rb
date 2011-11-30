class CreateUserTeamMemberships < ActiveRecord::Migration
  def change
    create_table :user_team_memberships do |t| 
      t.integer :user_id     
      t.integer :team_id 
      t.timestamps
    end
  end
end
