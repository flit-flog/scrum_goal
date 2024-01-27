class ChangeUserColumnTypeInDiariesTable < ActiveRecord::Migration[6.1]
  def change
    change_column :diaries, :user_id, :bigint
  end
end
