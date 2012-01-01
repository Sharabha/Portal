class AddStartColumnToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :start, :datetime
  end
end
