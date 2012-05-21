class AddAdminIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :admin_id, :integer
  end
end
