class CreateTreasures < ActiveRecord::Migration[6.1]
  def change
    create_table :treasures do |t|
      t.string :contents
      t.integer :pirate_id
      t.integer :island_id

      t.timestamps
    end
  end
end
