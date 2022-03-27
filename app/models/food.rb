class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :food_name, presence: true, uniqueness: true
end
