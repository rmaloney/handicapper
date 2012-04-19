require 'spec_helper'

describe "games/new" do
  before(:each) do
    assign(:game, stub_model(Game,
      :week => 1,
      :home_team => "MyString",
      :visitor_team => "MyString",
      :favorite => "MyString",
      :line => "9.99",
      :total => "9.99",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path, :method => "post" do
      assert_select "input#game_week", :name => "game[week]"
      assert_select "input#game_home_team", :name => "game[home_team]"
      assert_select "input#game_visitor_team", :name => "game[visitor_team]"
      assert_select "input#game_favorite", :name => "game[favorite]"
      assert_select "input#game_line", :name => "game[line]"
      assert_select "input#game_total", :name => "game[total]"
      assert_select "input#game_status", :name => "game[status]"
    end
  end
end
