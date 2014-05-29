require 'spec_helper'

describe NytimesMessenger do 

	before(:all) do 
  	@nyt = NytimesMessenger.new
	end

  describe "#format_search" do 
    it "formats a search query" do 
      format = @nyt.format_search("The Coca Cola Company")
      expect(format).to eq "Coca+AND+Cola"  
    end
  end

  describe "#create_query" do 
    before(:all) do 
      @uri = @nyt.create_query("The Coca Cola Company")
    end
    it "returns a string" do 
      @uri.should be_a_kind_of(String)
    end
    it "should include the formatted query" do 
      expect(@uri).to include("Coca+AND+Cola")
    end 
  end

  describe "#format_response" do 
    it "turns HTTParty::Response object into a hash" do 
      sample_obj = {"response"=>{"hits"=>7, "time"=>67, "offset"=>0}}
      result = @nyt.format_response(sample_obj)
      expect(result).to eq({"hits"=>7, "time"=>67, "offset"=>0}) # not sure this test makes any sense
    end
  end

  describe "#make_query" do 
    it "sends an HTTP get request to the NYT API" do 
      pending
    end
  end


end