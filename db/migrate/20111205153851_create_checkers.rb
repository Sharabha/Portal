class CreateCheckers < ActiveRecord::Migration
  def change
    create_table :checkers do |t|
      t.integer       :problem_id
      t.timestamps
    end
  end
end
