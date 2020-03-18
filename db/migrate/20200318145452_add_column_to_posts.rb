class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :publish_flg, default: true, null: false
  end
end
