class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :category
      t.string :description
      t.string :picture
      t.timestamps
    end
    add_index :products, :name, unique: true
    add_index :products, :category
  end

  def self.down
    drop_table :products
  end
end
