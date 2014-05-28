class FreebaseService
  def children(parent_name)
    resource = FreebaseAPI.session.mqlread([{ name: parent_name, type: "/organization/organization", child: [{ child: [] }] }])
    resource[0]["child"].map { |relationship| relationship["child"][0] }
  end

  def get_resource(company_name)
    FreebaseAPI::Topic.search(company_name)
  end

  def get_description(id)
    resource = FreebaseAPI::Topic.get(id)
    resource.description || "No Description Available for this company. "
  end

  def get_id(company)
    resource = FreebaseAPI::Topic.search(company)
    best_match = resource.values.first
    best_match.id
  end

  def get_parents(best_match)
    FreebaseAPI.session.mqlread({:id => best_match.id, :'/organization/organization/parent' => [{ :parent => [] }] })
  end
end

#FreebaseAPI.session.mqlread([{ name: "Viacom", type: "/organization/organization", child: [{ child: [] }] }])

