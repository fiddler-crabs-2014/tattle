class FreebaseService
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
end

