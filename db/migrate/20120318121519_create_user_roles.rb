class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :role
      t.references :user

      t.timestamps
    end
    add_index :user_roles, :role_id
    add_index :user_roles, :user_id
  end
end
