class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.references :user, type: :bigint, foreign_key: true
      t.references :team, type: :bigint, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
  