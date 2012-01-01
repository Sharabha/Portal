class AuthorColumnInProblem < ActiveRecord::Migration
  def change
    add_column :problems, :author_id, :integer
  end
end
