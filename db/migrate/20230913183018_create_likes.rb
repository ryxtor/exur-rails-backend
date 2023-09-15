class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :likeable_id
      t.string :likeable_type
      t.boolean :liked
      t.integer :user_id, foreign_key: true
      t.timestamps
    end

    add_index :likes, [:likeable_type, :likeable_id]
    add_foreign_key :likes, :users, column: :user_id
  end
end
