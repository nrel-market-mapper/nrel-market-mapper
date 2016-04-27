class ChangeTotalInstallsDefaultToZeroOnZipcodes < ActiveRecord::Migration
  def change
    change_column_default :zipcodes, :total_installs, 0
  end
end
