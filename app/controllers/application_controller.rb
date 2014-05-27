class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception



  private
  def self.generate_results(company_name)
    results = self.freebase_search(company_name)
    results["company"][:nyt] = self.fetch_articles(company_name)
    begin
      results["company"][:certifications] = Company.where("name like ?", "%#{company_name}%").first.certificates.pluck(:name)
    rescue
      results["company"][:certifications] = nil
    end
    if results["parents"]
      results["parents"].each do |parent|
        parent[:nyt] = self.fetch_articles(parent[:name]) if parent[:name]
      end
    end
    begin
      parent[:certifications] = Company.where("name like ?", "%#{parent[:name]}%").first.certificates.pluck(:name)
    rescue
    results
    end
  end

  def self.freebase_search(company_name)
    results = {"company" => { name: company_name }, }
    resource = FreebaseAPI::Topic.search(company_name)
    best_match = resource.values.first
    results[:industry] = best_match.as_json["data"]["property"]["/common/topic/notable_for"]["values"][0]["text"]
    id = best_match.id

    begin

      results["company"][:description] = self.get_description(self.get_id(company_name))

      parents = FreebaseAPI.session.mqlread({:id => best_match.id, :'/organization/organization/parent' => [{ :parent => [] }] })
      results["parents"] = [] if parents["/organization/organization/parent"]
      parents["/organization/organization/parent"].each_with_index do |parent, index|
        results["parents"] << {name: parent['parent'][0], description: self.get_description(get_id(parent['parent'][0]))} unless parent['parent'][0] == company_name || parent['parent'][0] == nil
        #results["parent"+(index+1).to_s][:description] = self.get_description(get_id(parent['parent'][0])) unless parent['parent'][0] == company_name || parent['parent'][0] == nil
    end

    rescue
    end

    results
  end

  def self.fetch_articles(query)
    nyt = NytimesMessenger.new
    nyt.make_query(query)
  end

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
