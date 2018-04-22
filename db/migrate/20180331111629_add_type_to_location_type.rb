class AddTypeToLocationType < ActiveRecord::Migration[5.1]
  def change
    add_column :location_types, :type, :string
  end
end
