class CreateCommonNames < ActiveRecord::Migration
  def change
    create_table :common_names do |t|
      t.integer :herb_id
      t.string :name

      t.timestamps
    end
  end
end
