require 'spec_helper'


describe FreebaseService do
  before(:all) do
    @freebase = FreebaseService.new("Pepsi")
    @freebase.stub(:get_description) { |num| "A description" }
    @freebase.stub(:get_id) { |company_name| 1 }
  end

  describe "#initialize" do
    it "assigns a results hash" do
      expect(@freebase.results).to be_kind_of(Hash)
    end
  end

  describe "#best_match" do
    it "calls get_resource" do
      @freebase.stub(:get_resource) do |company|
        company
      end
      @freebase.best_match({ a: "1", b: "2" }).should eq("1")
    end
  end

  describe "#search" do
    it "calls #get_description" do


    end
  end

end


























