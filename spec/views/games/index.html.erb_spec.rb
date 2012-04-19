require 'spec_helper'

describe "games/index" do
  before(:each) do
    assign(:games, [
      stub_model(Game,
        :week => 1,
        :home_team => "Home Team",
        :visitor_team => "Visitor Team",
        :favorite => "Favorite",
        :line => "9.99",
        :total => "9.99",
        :status => "Status"
      ),
      stub_model(Game,
        :week => 1,
        :home_team => "Home Team",
        :visitor_team => "Visitor Team",
        :favorite => "Favorite",
        :line => "9.99",
        :total => "9.99",
        :status => "Status"
      )
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Home Team".to_s, :count => 2
    assert_select "tr>td", :text => "Visitor Team".to_s, :count => 2
    assert_select "tr>td", :text => "Favorite".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
