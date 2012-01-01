class FixProblemAndProblemsMembership < ActiveRecord::Migration
  def change
    remove_column :problems, :start_time
    remove_column :problems, :end_time
    add_column :problem_memberships, :points, :integer
    add_column :problem_memberships, :start_time, :datetime
    add_column :problem_memberships, :end_time, :datetime
  end
end
