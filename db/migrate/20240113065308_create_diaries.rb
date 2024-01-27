class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
  