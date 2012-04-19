require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :week => 1,
      :home_team => "MyString",
      :visitor_team => "MyString",
      :favorite => "MyString",
      :line => "9.99",
      :total => "9.99",
      :status => "MyString"
    ))
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path(@game), :method => "post" do
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
