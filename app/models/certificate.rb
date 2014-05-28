require 'open-uri'

class Certificate < ActiveRecord::Base
  has_many :certifications
  has_many :companies, :through => :certifications

  def self.ftf_get_certs
    path = File.join(Rails.root, "db", "ftf_members.html")
    page = Nokogiri::HTML(open(path))

    body = "Fair Trade Federation"
    name = "Fair Trade Federation Mempership"
    category = "fair trade"

    @certificate = Certificate.create(body: body, name: name, category: category)
    page.css('h4').each { |element| @certificate.companies.create( name: element.text) }
  end


  def self.ftusa_get_certs
    # path = "http://www.fairtradeusa.org/products-partners"
    page = Nokogiri::HTML(open("http://www.fairtradeusa.org/products-partners").read)
    @certificate = Certificate.create(body: "Fair Trade USA", name: "Fair Trade USA Licensed Partner", category: "fair trade")
    page.css('.partner-name a').each { |element| @certificate.companies.create(name: element.text ) }
  end


  def self.rainforest_alliance_get_certs
    page = Nokogiri::HTML(open("http://www.rainforest-alliance.org/green-living/shopthefrog?country=all").read)
    @certificate = Certificate.create(body: "Rain Forest Alliance", name: "Rain Forest Alliance Certified", category: "environment")
    page.xpath('//div[2]/div[2]/div[2]/div/ul/li/a').each{ |element| @certificate.companies.create(name: element.text ) }
    page.xpath('//div[2]/div[2]/div[3]/div/ul/li/a').each{ |element| @certificate.companies.create(name: element.text ) }
    page.xpath('//div[4]/div/ul/li/a').each{ |element| @certificate.companies.create(name: element.text ) }
  end
  
  def self.usda_organics
    certificate = Certificate.create(body: "USDA", name: "USDA Certified Organic", category: "organic")
    path = File.join(Rails.root, "db", "usda.xlsx")
    workbook = RubyXL::Parser.parse(path)[0]
    companies = []
    workbook.extract_data.each {|entry| companies << entry[10]}
    companies.uniq!
    companies.each { |company| certificate.companies.create(name:company)}
  end
end
