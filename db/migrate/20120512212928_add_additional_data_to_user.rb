class AddAdditionalDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nick, :string
    add_column :users, :tshirt_size, :string

    add_column :teams, :organization, :string
  end
end
