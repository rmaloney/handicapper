class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :selection
      t.string :result
      t.string :status, :default => "open"

      t.timestamps
    end
  end
end
