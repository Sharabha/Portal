class CreateJudgeMemberships < ActiveRecord::Migration
  def change
    create_table :judge_memberships do |t|
      t.integer :judge_id
      t.integer :competition_id

      t.timestamps
    end
  end
end
