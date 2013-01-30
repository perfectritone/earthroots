class AddFieldsToHerb < ActiveRecord::Migration
  def change
    add_column( :herbs, :family, :string)
    add_column( :herbs, :genus, :string)
    add_column( :herbs, :species, :string)
    add_column( :herbs, :description, :text)
    add_column( :herbs, :harvest, :text)
    add_column( :herbs, :constituents, :text)
    add_column( :herbs, :traditional_uses, :text)
    add_column( :herbs, :overview, :text)
    add_column( :herbs, :safety, :text)
    add_column( :herbs, :dosage, :text)
    add_column( :herbs, :other_information, :text)
    add_column( :herbs, :resources, :text)
  end
end
