require 'spec_helper'


describe FreebaseService do 
  before(:all) do 
    @freebase = FreebaseService.new("Pepsi")
  end
  describe "#search" do 
    # it "calls #get_industry" do
    #   @results = {} 
    #   @results[:industry] = "beverage"
    #   result = @freebase.search("Pepsi").stub(:get_industry).and_return(:message)

    #   expect(result).to eq(:message)
    # end
  end

  describe "#best_match" do 
    it "calls #get_resource" do 
      # @freebase.stub(:get_resource).and_return(:message)

      # result = @freebase.best_match({name: "Pepsi"}).stub(:get_resource, "Pepsi").and_return(:message)

      # expect(result).to eq(:message)
    end
  end

end


























