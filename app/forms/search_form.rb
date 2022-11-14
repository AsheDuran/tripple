class CustomerSearchForm include ActiveModel::Model

  attr_accessor  :genre.name, :spot.name, :prefecture.name

  def search
    rel = Customer

    rel = rel.where(genre_id: id) if id.present?

    rel = rel.where(name: name) if name.present?

    rel = rel.joins(:address).where("address.tel" =&gt; tel) if tel.present?

    rel
  end
end