class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  private
  def generate_results(company_name)
    freebase = FreebaseService.new(company_name)
    results = freebase.search(company_name)

    results[:nyt] = fetch_articles(company_name)
    results["company"][:certifications] = certs_info(company_name)

    results = process_parents(results)
    puts "RESULTS NYT #{results[:nyt]}"
    results[:nyt] = clean_nyt(results[:nyt])
    results["parents"] = unique_parents(results["parents"])
    results
  end

  def certs_info(company_name)
    certs = fetch_certs(company_name)
    if certs
      certs.map do |certification|
        { name: certification.name, description: certification.description } unless certification.class == String
      end
    end
  end

  def clean_nyt(nyt_results)
    capitalize_headlines(nyt_results)
    minimize_dates(nyt_results)
    unique_nyt(nyt_results)
  end

  def unique_nyt(nyt_results)
    unique_results = []
    headlines = []
    nyt_results.each do |result|
      unique_results << result unless headlines.include?(result["headline"]["main"])
      headlines << result["headline"]["main"]
    end
    unique_results
  end

  def unique_parents(parents)
    unique_pars = []
    descriptions = []
    parents.each do |parent|
      unique_pars<< parent unless descriptions.include?(parent[:description])
      descriptions << parent[:description]
    end
    unique_pars
  end

  def minimize_dates(nyt_results)
    nyt_results.each do |result|
      result["pub_date"].chomp!("T00:00:00Z")
    end
  end

  def process_parents(results)
    if results["parents"]
      results["parents"].reverse!
      results["parents"].each do |parent|
        results[:nyt] += fetch_articles(parent[:name]) if parent[:name]
        results[:nyt].uniq!
        parent[:certifications] = certs_info(parent[:name])
      end
    end
    results
  end

  def fetch_certs(name)
    company = Company.where("name like ?", "%#{name}%").first
    if company
      company.certificates
    else
      nil
    end
  end

  def capitalize_headlines(nyt_results)
    nyt_results.each do |result|
      result["headline"]["main"].capitalize!
    end
  end

  def fetch_articles(query)
    nyt = NytimesMessenger.new
    begin
      nyt.make_query(query)["docs"]
    rescue
      []
    end
  end

end

