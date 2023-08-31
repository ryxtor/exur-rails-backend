class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :birth_date, :date
    add_column :users, :admin, :boolean, default: false
    add_column :users, :explorer, :boolean, default: false
    add_column :users, :gender, :integer
  end
end
