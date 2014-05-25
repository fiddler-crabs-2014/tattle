require 'spec_helper'

describe ApplicationController do 
	before(:each) do 
		@result = ApplicationController.generate_results("PepsiCo")
	end
	describe "#generate_results" do 
		expect(@result).to_not be_nil
	end
end