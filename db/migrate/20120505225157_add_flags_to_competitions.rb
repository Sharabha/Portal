class AddFlagsToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :is_active, :boolean, :default=>false, :null=> false
    add_column :competitions, :needs_confirmation, :boolean, :default=>false, :null=> false
  end
end
