class Recipe < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :recipe_name, presence: true
  validates :man_count, presence: true
  validates :recipe, presence: true
  validates :point, presence: true
end
