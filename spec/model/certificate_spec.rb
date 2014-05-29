require 'spec_helper'

describe Certificate do
	it { should have_many(:certifications) }
  it { should have_many(:companies) }

end
