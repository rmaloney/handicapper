class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :game_id
      t.integer :favorite_score
      t.integer :underdog_score
      t.string :line_result
      t.string :total_result

      t.timestamps
    end
  end
end
