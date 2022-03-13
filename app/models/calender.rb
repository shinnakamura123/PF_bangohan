class Calender < ApplicationRecord
  has_many :menus, dependent: :destroy
  has_many :lists, through: :menus, dependent: :destroy

  belongs_to :user

accepts_nested_attributes_for :menus, allow_destroy: true

end
