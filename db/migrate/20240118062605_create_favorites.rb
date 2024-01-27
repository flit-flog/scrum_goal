class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
    t.references :user, type: :bigin, foreign_key: true
    t.references :diary, type: :bigin, foreign_key: true

    t.timestamps
    end
  end
end
