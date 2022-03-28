class Recipe < ApplicationRecord

  belongs_to :user, optional: true
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_one_attached :image

  #中間テーブルへの保存を許可する
  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :recipe_foods, allow_destroy: true

  validates :recipe_name, presence: true
  validates :man_count, presence: true
  validates :background, presence: true, length: {maximum: 140}
  validates :point, presence: true, length: {maximum: 140}

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

  #いいねをしているか確認
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, tag_id, food_id)
    #レシピ名で検索した場合
    if search
      where(['recipe_name LIKE ?', "%#{search}%"])
    #タグ名で検索した場合
    elsif tag_id.present?
      joins(:tags).where(tags: { id: tag_id })
    #材料名で検索した場合
    elsif food_id.present?
      joins(:foods).where(foods: { id: food_id })
    else
      all
    end
  end

end
