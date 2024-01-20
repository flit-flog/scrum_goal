class RemoveBodyFromDiaries < ActiveRecord::Migration[6.1]
  def change
    remove_column :diaries, :body, :text
  end
end
