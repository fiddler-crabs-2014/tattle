class Certificate < ActiveRecord::Base
  has_many :certifications
  has_many :companies, :through => :certifications
    def self.get_certs
      path = File.join(Rails.root, "config", "ftf_members.html")
      page = Nokogiri::HTML(open(path))

      body = "Fair Trade Federation"
      name = "Fair Trade Federation Mempership"
      category = "fair trade"

      @certificate = Certificate.create(body: body, name: name, category: category)
      page.css('h4').each { |element| @certificate.companies.create( name: element.text) }
    end
end
