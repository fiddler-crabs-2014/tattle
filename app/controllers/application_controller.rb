class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def self.generate_results(company_name)
    results = {}
    companies = self.freebase_search(company_name)
    companies.each do |company|
      results[company] = { nyt: self.search_articles(company)}
    end
    results
  end


  def self.freebase_search(company_name)
    companies = []
    resource = FreebaseAPI.session.mqlread({:name => company_name, :'/organization/organization/parent' => [{ :parent => nil }] })
    resource["/organization/organization/parent"].each { |parent|  companies << parent['parent'] }
    companies.unshift(company_name)
    companies
  end

  def self.search_articles ( query )
    query.chomp!(" Co")
    query_formatted = query.gsub(" ", "+")
    puts "#{ENV["NYT_ARTICLE_KEY"]}"

    uri = "http://api.nytimes.com/svc/search/v1/article?format=json&query=" + query_formatted + "+opposition&fields=title%2C+date%2C+url&api-key=" + ENV["NYT_ARTICLE_KEY"]

    result = HTTParty.get( uri )
    puts "RESULT #{result}"
    formatted_result = result.to_hash.symbolize_keys[:results]

  end

end
