require 'spec_helper'

describe Company do 
  it { should belong_to(:industry) }
  it { should have_many(:certifications) }
  it { should have_many(:certificates) }
end