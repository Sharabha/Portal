class CreateProblemTable < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.references :competition
      t.string :name
      t.timestamps
    end
  end
end
