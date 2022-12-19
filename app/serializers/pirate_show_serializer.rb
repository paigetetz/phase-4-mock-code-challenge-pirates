class PirateShowSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :islands
end
