class Company < ActiveRecord::Base
  belongs_to :industry
  has_many :certifications
  has_many :certificates, :through => :certifications
end
