class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :number
      t.integer :total_installs
      t.references :county, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
