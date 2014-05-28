class FreebaseService
  def children(parent_name)
    self.get_children_names(self.get_children_ids(parent_name))
  end
  def get_children_ids(parent_name)
    children = FreebaseAPI.session.mqlread([{ name: parent_name, type: "/organization/organization", child: [{ id: nil }] }])
    children[0]["child"].map { |child| child["id"] }
  end
  def get_children_names(ids)
    children_names = ids.map { |child_id| self.get_child_name(child_id) }
  end

  def get_child_name(child_id)
    relationship = FreebaseAPI.session.mqlread([id: child_id, type: "/organization/organization_relationship", child: [{ name: nil }]])
    begin
    relationship[0]["child"][0]["name"]
    rescue
    end
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

