class ClientsQuery
  attr_reader :relation

  def initialize(relation = Client.all)
    @relation = relation
  end

  def firstname_like(firstname)
    return relation unless firstname
    relation.where("firstname ILIKE ?", "%#{firstname}%")
  end

  def lastname_like(lastname)
    return relation unless lastname
    relation.where("lastname ILIKE ?", "%#{lastname}%")
  end

  def id_like(id)
    id.blank? ? relation : relation.where("id = ?", id)
  end
end