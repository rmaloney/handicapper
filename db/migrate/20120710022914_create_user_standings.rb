class CreateUserStandings < ActiveRecord::Migration
  def change
    create_table :user_standings do |t|

      t.timestamps
    end
  end
end
