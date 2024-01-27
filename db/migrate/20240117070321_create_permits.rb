class CreatePermits < ActiveRecord::Migration[6.1]
  def change
    create_table :permits do |t|
      t.references :user, type: :bigint, foreign_key: true
      t.references :team, type: :bigint, foreign_key: true

      t.timestamps
    end
  end
end
