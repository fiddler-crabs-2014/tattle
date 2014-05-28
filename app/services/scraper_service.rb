class ScraperService

  def ftf_get_certs
    path = File.join(Rails.root, "db", "ftf_members.html")
    page = Nokogiri::HTML(open(path))

    body = "Fair Trade Federation"
    name = "Fair Trade Federation Mempership"
    category = "fair trade"
    description = "FTF’s membership screening process consists of a self-reported application designed to gather information about applicants’ holistic commitment to fair trade in all facets of the business model, including the product supply chain."
    @certificate = Certificate.create(body: body, name: name, category: category, description: description)
    page.css('h4').each { |element| @certificate.companies.create( name: element.text) }
  end


  def ftusa_get_certs
    description = "Fair Trade USA audits and certifies transactions between U.S. companies and their international suppliers to guarantee that the farmers and workers producing Fair Trade Certified goods are paid fair prices and wages, work in safe conditions, protect the environment and receive community development funds to empower and uplift their communities."
    page = Nokogiri::HTML(open("http://www.fairtradeusa.org/products-partners").read)
    @certificate = Certificate.create(body: "Fair Trade USA", name: "Fair Trade USA Licensed Partner", category: "fair trade", description: description)
    page.css('.partner-name a').each { |element| @certificate.companies.create(name: element.text ) }
  end


  def rainforest_alliance_get_certs
  	description = "The Rainforest Alliance Certified seal assures consumers that the product they are purchasing has been grown and harvested using environmentally and socially responsible practices. Farms and forestlands that meet the rigorous, third-party standards of the Sustainable Agriculture Network or the Forest Stewardship Council are awarded the Rainforest Alliance Certified seal."
    page = Nokogiri::HTML(open("http://www.rainforest-alliance.org/green-living/shopthefrog?country=all").read)
    @certificate = Certificate.create(body: "Rain Forest Alliance", name: "Rain Forest Alliance Certified", category: "environment", description: description)
    page.xpath('//div[2]/div[2]/div[2]/div/ul/li/a').each{ |element| @certificate.companies.create(name: element.text ) }
    page.xpath('//div[2]/div[2]/div[3]/div/ul/li/a').each{ |element| @certificate.companies.create(name: element.text ) }
    page.xpath('//div[4]/div/ul/li/a').each{ |element| @certificate.companies.create(name: element.text ) }
  end
  
  def usda_organics
  	description = "USDA certified organic foods are grown and processed according to federal guidelines addressing, among many factors, soil quality, animal raising practices, pest and weed control, and use of additives. Organic producers rely on natural substances and physical, mechanical, or biologically based farming methods to the fullest extent possible."
    certificate = Certificate.create(body: "USDA", name: "USDA Certified Organic", category: "organic", description: description)
    path = File.join(Rails.root, "db", "usda.xlsx")
    workbook = RubyXL::Parser.parse(path)[0]
    companies = []
    workbook.extract_data.each {|entry| companies << entry[10]}
    companies.uniq!
    companies.each { |company| certificate.companies.create(name:company)}
  end

end