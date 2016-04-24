class AddLatAndLongToStates < ActiveRecord::Migration
  def change
    add_column :states, :lat, :float
    add_column :states, :long, :float
  end
end
