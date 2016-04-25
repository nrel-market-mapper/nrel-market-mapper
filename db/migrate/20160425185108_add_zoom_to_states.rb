class AddZoomToStates < ActiveRecord::Migration
  def change
    add_column :states, :zoom, :integer, default: 6
  end
end
