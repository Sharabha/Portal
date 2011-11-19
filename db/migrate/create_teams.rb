class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :team_id
      t.integer :competition_id
      t.integer :leader_id
      t.string :name

      t.timestamps
    end
  end
end
