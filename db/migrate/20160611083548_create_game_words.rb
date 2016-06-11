class CreateGameWords < ActiveRecord::Migration
  def change
    create_table :game_words do |t|
      t.string :answer
      t.string :clue

      t.timestamps null: false
    end
  end
end
