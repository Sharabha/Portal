class AddMaxMemoryToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :max_memory, :integer
  end
end
