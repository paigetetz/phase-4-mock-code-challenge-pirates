class Island < ApplicationRecord
    has_many :treasures
    has_many :pirates, through: :treasures

    validates :name, presence: true
end
