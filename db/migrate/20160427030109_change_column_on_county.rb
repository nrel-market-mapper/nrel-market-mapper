class ChangeColumnOnCounty < ActiveRecord::Migration
  def change
    enable_extension "citext"

    change_column :counties, :name, :citext, null: false
  end
end
