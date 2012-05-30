class AddFormatToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :format, :string
  end
end
