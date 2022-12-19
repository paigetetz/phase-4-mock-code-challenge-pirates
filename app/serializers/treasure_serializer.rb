class TreasureSerializer < ActiveModel::Serializer
  attributes :id, :contents, :pirate_id, :island_id
end
