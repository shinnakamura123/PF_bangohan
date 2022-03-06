class List < ApplicationRecord
  has_many :menus, dependent: :destroy
  belongs_to :user
  belongs_to :recipe
end
