class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :publish_flg, :boolean, default: false, null: false
    add_column :posts, :thumbnail_image, :string
  end
end
