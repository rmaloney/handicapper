class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :week
      t.string :home_team
      t.string :visitor_team
      t.string :favorite
      t.decimal :line
      t.decimal :total
      t.time :kickoff
      t.string :status

      t.timestamps
    end
  end
end
