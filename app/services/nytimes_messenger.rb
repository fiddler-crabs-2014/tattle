class NytimesMessenger

  def format_search(query)
    query.chomp(" co").chomp(" Co").chomp(" Company").gsub(":", "").gsub(/\/\)\*\(\&\^\%\$\#\@\!/, "").gsub("The ", "").gsub(" ", "+AND+").tr( "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž", "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
  end

  def create_query(query)
    return ("http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=organizations.contains:(" + self.format_search(query) + ")+AND+document_type:(article)+AND+subject.contains:(Environment+Obesity+Labor+Cruelty)&fl=headline,web_url,pub_date,keywords&api-key=9f7876895414dc78acc8fe1c9a0dbd03:16:63558649")
  end

  def format_response(results)
    results.to_hash.symbolize_keys[:response]
  end

  def make_query(query)
    response = HTTParty.get(self.create_query(query))
    ap response
    self.format_response(response)
  end
end
