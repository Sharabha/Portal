class CreateCompetitorMemberships < ActiveRecord::Migration
  def change
    create_table :competitor_memberships do |t|
      t.integer :competitor_id
      t.integer :competition_id

      t.timestamps
    end
  end
end
