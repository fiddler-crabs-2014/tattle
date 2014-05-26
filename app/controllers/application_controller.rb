class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  private
  def self.generate_results(company_name)
    results = {}
    companies = self.freebase_search(company_name)
    companies.each_with_index do |company, index|
      if index == 0
        results["company"] = { name: company, nyt: self.search_articles(company)}
        begin
          results["company"][:certifications] = Company.where("name like ?", "%#{company}%").first.certificates.pluck(:name)
        rescue
          results["company"][:certifications] = "None"
        end
      else
        results["parent"+index.to_s] = { name: company, nyt: self.search_articles(company)}
        begin
          results["parent"+index.to_s][:certifications] = Company.where("name like ?", "%#{company}%").first.certificates.pluck(:name)
        rescue
          results["parent"+index.to_s][:certifications] = "None"
        end
      end
    end
    results
  end

  def self.freebase_search(company_name)
    companies = []
    begin
      resource = FreebaseAPI.session.mqlread({:name => company_name.capitalize!, :'/organization/organization/parent' => [{ :parent => nil }] })
      resource["/organization/organization/parent"].each { |parent|  companies << parent['parent'] } if resource
    rescue
    end
    companies.unshift(company_name)
    companies
  end

  def self.search_articles ( query )
    query.chomp!(" co")
    query_formatted = query.gsub(" ", "+")

    uri = "http://api.nytimes.com/svc/search/v1/article?format=json&query=" + query_formatted + "+opposition&fields=title%2C+date%2C+url&api-key=" + "9f7876895414dc78acc8fe1c9a0dbd03:16:63558649"

    result = HTTParty.get( uri )

    formatted_result = result.to_hash.symbolize_keys[:results]

  end

end
