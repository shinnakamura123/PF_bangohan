class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :start_time, presence: true
end
