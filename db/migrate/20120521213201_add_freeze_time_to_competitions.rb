class AddFreezeTimeToCompetitions < ActiveRecord::Migration
  def change
	add_column :competitions, :freeze_time, :datetime
  end
end
