require 'spec_helper'

describe ApplicationController do 
  describe "#generate_results" do 
    context "has a parent company with no certifications" do 
      before(:all) do
        @results = ApplicationController.generate_results("Burt's Bees")
      end

      context "has a parent company" do

        it { @results.should be_a_kind_of(Hash) }
        
        it { @results.should_not be_empty }

        it { @results["parent1"][:name].should include("Clorox")}
      end

      context "has no certifications" do 
        it { @results["parent1"][:certifications].should include("None")}      
      end
    end

  end



  describe "#freebase_search" do 
    before(:all) do 
      @freebase_result = ApplicationController.freebase_search("Burt's Bees")
    end

    it { @freebase_result.should be_a_kind_of(Array) }

    it { @freebase_result.should include("Clorox") }

  end


  describe "#search_articles" do 
    before(:all) do 
      @articles_result = ApplicationController.search_articles("Burt's Bees")
    end

    it { @articles_result.should be_a_kind_of(Array) }

    it { @articles_result[0].should include("date") }
    it { @articles_result[0].should include("title") }
    it { @articles_result[0].should include("url") }


  end

end