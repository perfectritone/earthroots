class AddGeneralBooleanFieldToLinksAndBooks < ActiveRecord::Migration
  def change
    add_column :links, :general, :boolean, default: true
    add_column :books, :general, :boolean, default: true
  end
end
