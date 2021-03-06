class CreateProductSizes < ActiveRecord::Migration
  def self.up
    create_table :product_sizes do |t|
      t.integer :product_id
      t.string :size
      t.decimal :price
      t.timestamps
    end
  end

  def self.down
    drop_table :product_sizes
  end
end
