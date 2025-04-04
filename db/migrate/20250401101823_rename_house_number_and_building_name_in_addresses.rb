class RenameHouseNumberAndBuildingNameInAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :house_number, :address
    rename_column :addresses, :building_name, :building
  end
end