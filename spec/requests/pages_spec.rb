require 'spec_helper'

describe "Pages" do
 
	describe "About page" do
	    it "Should have the content 'About'" do
	    	visit '/pages/about'
	    	page.should have_content('About')
	   	end
	end

	describe "Help page" do
		it "Should have the content 'Help'" do
			visit '/pages/help'
			page.should have_content('Help')
		end
	end
end
