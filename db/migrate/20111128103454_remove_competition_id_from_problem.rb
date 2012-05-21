class RemoveCompetitionIdFromProblem < ActiveRecord::Migration
  def up
    remove_column :problems, :competition_id
  end

  def down
    add_column :problems, :competition_id, :integer
  end
end
