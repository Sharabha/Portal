class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.integer     :owner_id
      t.string      :name
      t.text        :description
      t.datetime    :deadline
      t.timestamps
    end
  end
end
