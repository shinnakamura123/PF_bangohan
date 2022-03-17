class List < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.search(search)
    if search
      List.joins(:recipe).where(['recipe_name LIKE ?', "%#{search}%"])
    else
      List.all  #検索結果が当てはまらない場合は全て表示
    end
  end
  
end
