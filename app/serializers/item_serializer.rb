class ItemSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :unit_price, :merchant_id

  #need to add relationships
end
