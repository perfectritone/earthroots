class CreateIndications < ActiveRecord::Migration
  def change
    create_table :indications do |t|
      t.integer :herb_id
      t.string :name

      t.timestamps
    end
  end
end
