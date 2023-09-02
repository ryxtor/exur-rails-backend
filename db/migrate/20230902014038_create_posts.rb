# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :text, null: false
      t.integer :user_id, foreign_key: true
      t.timestamps
    end

    add_foreign_key :posts, :users, column: :user_id
  end
end
