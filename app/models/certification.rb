class Certification < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :company
end
