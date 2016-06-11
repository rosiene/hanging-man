class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :name
      t.integer :tries
      t.integer :game

      t.timestamps null: false
    end
  end
end
