class CreateCheckerData < ActiveRecord::Migration
  def change
    create_table :checker_data do |t|
      t.integer     :checker_id
      t.text        :input
      t.text        :output
      t.timestamps
    end
  end
end
