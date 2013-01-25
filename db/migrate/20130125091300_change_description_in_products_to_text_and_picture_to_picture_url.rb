class ChangeDescriptionInProductsToTextAndPictureToPictureUrl < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.remove :description
      t.text :description
    end
    rename_column :products, :picture, :picture_url
  end
end
