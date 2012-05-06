class AddLanguageToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :language, :string
  end
end
