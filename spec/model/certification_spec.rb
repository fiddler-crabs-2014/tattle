require 'spec_helper'

describe Certification do 
	it { should belong_to(:certificate) }
  it { should belong_to(:company) }
end