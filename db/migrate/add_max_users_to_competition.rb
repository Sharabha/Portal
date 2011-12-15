class AddMaxUsersToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :max_users, :integer, :default => 1
  end
end