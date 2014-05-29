class FreebaseService
  attr_reader :results
  def initialize(company_name)
    @company_name = company_name
    # @best_match = nil
    @results = { "company" => { name: company_name }, "parents" => [] , nyt: []}
  end

  def children(parent_name)
    children = FreebaseAPI.session.mqlread([{ name: parent_name, type: "/organization/organization", child: [{ child: [] }] }])
    children[0]["child"].map { |relationship| relationship["child"][0] }.uniq
  end

  def get_resource(company)
    FreebaseAPI::Topic.search(company)
  end

  def best_match(company)
    begin
      get_resource(company).values.select { |x| x.name == company }.first
    rescue
      get_resource(company).values.first
    end
  end

  def get_description(id)
    resource = FreebaseAPI::Topic.get(id)
    resource.description || "No Description Available for this company. "
  end

  def get_id(company_name)
    best_match(company_name).id if best_match(company_name)
  end

  def get_parents
    FreebaseAPI.session.mqlread({:id => get_id(@company_name), :'/organization/organization/parent' => [{ :parent => [] }] })
  end

  def populate_parents
    parents = get_parents
    puts "PARENTS: #{parents}"
    if parents
      parents["/organization/organization/parent"].each do |parent|
        unless parent['parent'][0] == @company_name || parent['parent'][0] == nil || parent['parent'][0].match("Independent company")
          results["parents"] << { name: parent['parent'][0], description: get_description(get_id(parent['parent'][0])) }
        end
      end
    end
  end

  def search(company_name)
    results["company"][:description] = get_description(get_id(@company_name))
    populate_parents
    results
  end

end


