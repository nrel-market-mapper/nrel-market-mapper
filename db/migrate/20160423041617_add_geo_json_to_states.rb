class AddGeoJsonToStates < ActiveRecord::Migration
  def change
    add_column :states, :geojson, :text
  end
end
