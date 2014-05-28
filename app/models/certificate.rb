require 'open-uri'

class Certificate < ActiveRecord::Base
  has_many :certifications
  has_many :companies, :through => :certifications

  
end
