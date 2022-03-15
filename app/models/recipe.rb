class Recipe < ApplicationRecord

  belongs_to :user, optional: true
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

  #中間テーブルへの保存を許可する
  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :recipe_foods, allow_destroy: true

  validates :recipe_name, presence: true
  validates :man_count, presence: true
  validates :background, presence: true
  validates :point, presence: true

  enum status: { false: 0, true: 1 }

  def listed_by?(user)
    lists.where(user_id: user).exists?
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
