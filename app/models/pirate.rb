class Pirate < ApplicationRecord
    has_many :treasures
    has_many :islands, through: :treasures
    validates :name, presence: true
    validates :age, numericality: { greater_than_or_equal_to: 18 , less_than_or_equal_to: 100 }
end
