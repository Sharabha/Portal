class ProblemsColumnUpdate < ActiveRecord::Migration
  def change
    add_column :problems, :start_time, :datetime
    add_column :problems, :end_time, :datetime
    add_column :problems, :points, :integer
    add_column :problems, :description, :text
  end
end
