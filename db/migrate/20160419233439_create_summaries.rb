class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.string :year
      t.decimal :avg_cost
      t.decimal :capacity
      t.integer :total_installs
      t.references :state, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
