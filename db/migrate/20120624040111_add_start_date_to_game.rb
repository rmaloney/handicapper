class AddStartDateToGame < ActiveRecord::Migration
  def change
    add_column :games, :start_date, :date

  end
end
