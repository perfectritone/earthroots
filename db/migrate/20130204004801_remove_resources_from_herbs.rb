class RemoveResourcesFromHerbs < ActiveRecord::Migration
  def up
    remove_column :herbs, :resources
  end

  def down
    add_column :herbs, :resources, :string
  end
end
