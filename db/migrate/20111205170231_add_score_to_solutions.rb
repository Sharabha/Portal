class AddScoreToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :score, :float, :default => 0.0
  end
end
