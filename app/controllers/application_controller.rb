class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  private
  def self.generate_results(company_name)
   results = self.freebase_search(company_name)
    results.each do |key, value|
      if key == "company"
        results["company"][:nyt] = self.search_articles(company_name)
        begin
          results["company"][:certifications] = Company.where("name like ?", "%#{company}%").first.certificates.pluck(:name)
        rescue
          results["company"][:certifications] = "None"
        end
      elsif key.to_s.match("parent")
        results[key][:nyt] = self.search_articles(value[:name])
        begin
          results[key][:certifications] = Company.where("name like ?", "%#{company}%").first.certificates.pluck(:name)
        rescue
        end
      end
    end
    results
  end

  def self.freebase_search(company_name)
    results = {"company" => { name: company_name }}
    resource = FreebaseAPI::Topic.search(company_name)
    best_match = resource.values.first
    results[:industry] = best_match.as_json["data"]["property"]["/common/topic/notable_for"]["values"][0]["text"]
    id = best_match.id
    begin

      results["company"][:description] = self.get_description(self.get_id(company_name))

      parents = FreebaseAPI.session.mqlread({:id => best_match.id, :'/organization/organization/parent' => [{ :parent => [] }] })

      parents["/organization/organization/parent"].each_with_index do |parent, index|
        results["parent"+(index+1).to_s] = {name: parent['parent'][0]} unless parent['parent'][0] == company_name
        results["parent"+(index+1).to_s][:description] = self.get_description(get_id(parent['parent'][0])) unless parent['parent'][0] == company_name
      end

    rescue
    end

    results
  end

  def self.search_articles ( query )
    query.chomp!(" co")
    query_formatted = query.gsub(" ", "+")

    uri = "http://api.nytimes.com/svc/search/v1/article?format=json&query=" + query_formatted + "+opposition&fields=title%2C+date%2C+url&api-key=" + "9f7876895414dc78acc8fe1c9a0dbd03:16:63558649"

    result = HTTParty.get( uri )

    formatted_result = result.to_hash.symbolize_keys[:results]

  end

  def self.get_description(id)
    resource = FreebaseAPI::Topic.get(id)
    resource.description
  end

  def self.get_id(company)
    resource = FreebaseAPI::Topic.search(company)
    best_match = resource.values.first
    best_match.id
  end

end
