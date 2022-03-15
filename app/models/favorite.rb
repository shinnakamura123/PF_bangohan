class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  #いいね一回制限
  validates_uniqueness_of :recipe_id, scope: :user_id

  def self.search(search)
    if search
      Favorite.joins(:recipe).where(['recipe_name LIKE ?', "%#{search}%"])
    else
      Favorite.all  #検索結果が当てはまらない場合は全て表示
    end
  end
end
