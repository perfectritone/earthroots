class AddPartsUsedToHerb < ActiveRecord::Migration
  def change
    add_column( :herbs, :parts_used, :string )
  end
end
