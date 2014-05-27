require 'spec_helper'

describe Industry do 
  it { should have_many(:companies) }
end