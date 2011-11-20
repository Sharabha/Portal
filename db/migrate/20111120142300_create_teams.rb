class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :leader_id
      t.string  :name

      t.timestamps
    end
  end
end
