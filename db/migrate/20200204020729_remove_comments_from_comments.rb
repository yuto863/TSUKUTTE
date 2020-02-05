class RemoveCommentsFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :comments, :string
  end
end
