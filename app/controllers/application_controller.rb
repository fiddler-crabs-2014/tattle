class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception



  private
  def self.generate_results(company_name)
   results = self.freebase_search(company_name)
    results.each do |key, value|
      if key == "company"
        results["company"][:nyt] = self.make_query(company_name)
        begin
          results["company"][:certifications] = Company.where("name like ?", "%#{company_name}%").first.certificates.pluck(:name)
        rescue
          results["company"][:certifications] = nil
        end
      elsif key.to_s.match("parent")
        results[key][:nyt] = self.make_query(value[:name]) if value[:name]
        begin
          results[key][:certifications] = Company.where("name like ?", "%#{value[:name]}%").first.certificates.pluck(:name)
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
        results["parent"+(index+1).to_s] = {name: parent['parent'][0]} unless parent['parent'][0] == company_name || parent['parent'][0] == nil
        results["parent"+(index+1).to_s][:description] = self.get_description(get_id(parent['parent'][0])) unless parent['parent'][0] == company_name || parent['parent'][0] == nil
      end

    rescue
    end

    results
  end


  #####TIMES SEARCH
  def self.format_search(query)
    query.chomp!(" co")
    query_formatted = query.gsub(" ", "+")
  end

  def self.create_query(query)
    return ("http://api.nytimes.com/svc/search/v2/articlesearch.json?&fq=document_type:(article)+AND+subject.contains:(Environment+Obesity+Rights+Labor+Cruelty)+AND+organizations.contains:(" + self.format_search(query) + ")&fl=headline,web_url&api-key=9f7876895414dc78acc8fe1c9a0dbd03:16:63558649")
  end

  def self.format_response(results)
    results.to_hash.symbolize_keys[:response]
  end
  
  def self.make_query(query)
    response = HTTParty.get(self.create_query(query))
    self.format_response(response)
  end
  #########
  # def self.search_articles ( query )
  #   p query
  #   query.chomp!(" co")
  #   # p "query : " + query
  #   query_formatted = query.gsub(" ", "+")
  #   # p "query formatted: " + query_formatted

  #   uri = "http://api.nytimes.com/svc/search/v1/article?format=json&query=" + query_formatted + "+opposition&fl=title%2C+date%2C+url&api-key=" + "9f7876895414dc78acc8fe1c9a0dbd03:16:63558649"

  #   result = HTTParty.get( uri )

  #   formatted_result = result.to_hash.symbolize_keys[:results]
  #   formatted_result
  # end

  def self.get_description(id)
    resource = FreebaseAPI::Topic.get(id)
    resource.description || "No Description Available for this company. "
  end

  def self.get_id(company)
    resource = FreebaseAPI::Topic.search(company)
    best_match = resource.values.first
    best_match.id
  end

end
