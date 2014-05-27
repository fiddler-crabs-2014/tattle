class NytimesMessenger
  def format_search(query)
    query.chomp!(" co")
    query_formatted = query.gsub(" ", "+")
  end

  def create_query(query)
    return ("http://api.nytimes.com/svc/search/v2/articlesearch.json?&fq=document_type:(article)+AND+subject.contains:(Environment+Obesity+Rights+Labor+Cruelty)+AND+organizations:(" + self.format_search(query) + ")&fl=headline,web_url,pub_date&api-key=9f7876895414dc78acc8fe1c9a0dbd03:16:63558649")
  end

  def format_response(results)
    results.to_hash.symbolize_keys[:response]
  end
  
  def make_query(query)
    response = HTTParty.get(self.create_query(query))
    self.format_response(response)
  end
end