require 'spec_helper'

describe Certificate do 
	it { should have_many(:certifications) }
  it { should have_many(:companies) }

  describe "#ftf_get_certs" do 
    before(:each) do 
      Certificate.ftf_get_certs
    end

    it "should create a Fair Trade Federation certificate in the Certificates table" do 
      expect(Certificate.find_by_name("Fair Trade Federation Mempership")).to_not be_nil
    end
    it "should create companies with the Fair Trade Federation certification" do 
      expect( (Certificate.find_by_name("Fair Trade Federation Mempership").companies.count) ).to_not eq 0
    end
  end


  describe "#ftusa_get_certs" do 
    before(:each) do 
      Certificate.ftusa_get_certs
    end

    it "should create a Fair Trade USA certificate in the Certificates table" do 
      expect(Certificate.find_by_name("Fair Trade USA Licensed Partner")).to_not be_nil
    end
    it "should create companies with the Fair Trade USA certification" do 
      expect( (Certificate.find_by_name("Fair Trade USA Licensed Partner").companies.count) ).to_not eq 0
    end
  end

  describe "#rainforest_alliance_get_certs" do 
    before(:each) do 
      Certificate.rainforest_alliance_get_certs
    end

    it "should create a Rainforest Alliance certificate in the Certificates table" do 
      expect(Certificate.find_by_name("Rain Forest Alliance Certified")).to_not be_nil
    end
    it "should create companies with the Rainforest Alliance certification" do 
      expect( (Certificate.find_by_name("Rain Forest Alliance Certified").companies.count) ).to_not eq 0
    end
  end



end