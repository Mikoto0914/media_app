class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name,    :string, null: false, default: ""
    add_column :users, :profile, :string
    add_column :users, :image,   :string
  end
end
