class AddHerbsProductsJoinTable < ActiveRecord::Migration
  def up
    create_table :herbs_products, id: false do |t|
      t.integer :herb_id
      t.integer :product_id
    end
  end

  def down
    drop_table :herbs_products
  end
end
