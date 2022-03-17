class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, dependent: :destroy
  has_many :recipes, dependent: :destroy
  # マイリストに追加しているレシピ一覧を表示する
  has_many :list_recipes, through: :lists, source: :recipe
  has_many :menus, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :comments, dependent: :destroy
   # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed


  validates :email, uniqueness: true
  validates :name, uniqueness: true, presence: true

  def follow(user) #フォローするメソッド
    relationships.create(followed_id: user.id)
  end

  def unfollow(user) #フォローを外すメソッド
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user) #フォローに含まれているか確認するメソッド（ボタン切り替え用）
    followings.include?(user)
  end


end
