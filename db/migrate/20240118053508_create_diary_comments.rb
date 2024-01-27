class CreateDiaryComments < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_comments do |t|
      t.text :comment
      t.references :user, type: :bigin, foreign_key: true
      t.references :diary, type: :bigin, foreign_key: true
      t.timestamps
    end
  end
end
