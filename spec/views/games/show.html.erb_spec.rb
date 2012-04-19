require 'spec_helper'

describe "games/show" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :week => 1,
      :home_team => "Home Team",
      :visitor_team => "Visitor Team",
      :favorite => "Favorite",
      :line => "9.99",
      :total => "9.99",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Home Team/)
    rendered.should match(/Visitor Team/)
    rendered.should match(/Favorite/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/Status/)
  end
end
