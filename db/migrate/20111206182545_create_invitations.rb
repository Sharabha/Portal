class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :team_id
      t.string  :token
      t.boolean :confirmed, :default => false

      t.timestamps
    end
  end
end
