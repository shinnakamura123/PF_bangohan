class Calender < ApplicationRecord
  has_many :menus, dependent: :destroy
  belongs_to :user

  validates :calender_date, presence: true
end
