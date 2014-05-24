class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def self.generate_results(company_name)
    results = {"nyt_results" => self.nyt_search(self.freebase_search(company_name))}#.to_json
  end

  def self.nyt_search(companies)
    search_results = {}
    companies.each do |company|
      #do some NYT search
      #search_results[parent] = resultlt of NYT search
      puts "Inside the NYT: #{company}"
      search_results[company] = company

    end
    search_results
  end

  def self.freebase_search(company_name)
    resource = FreebaseAPI.session.mqlread({:name => company_name, :'/organization/organization/parent' => [{ :parent => nil }] })
    puts "RESOURCE: #{resource.inspect}"
    companies = resource["/organization/organization/parent"].map { |parent| parent["parent"] }
    companies << company_name
    puts "COMPANIES: #{companies}"
    companies
  end
end
