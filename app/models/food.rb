class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy

  validates :food_name, presence: true
  validates :unit, presence: true
end