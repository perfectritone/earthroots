class CreateHerbResources < ActiveRecord::Migration
  def change
    create_table :herb_resources do |t|
      t.integer :herb_id
      t.integer :link_id
      t.integer :book_id

      t.timestamps
    end
  end
end
