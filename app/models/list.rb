class List < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.search(search, tag_id)
    if search
      joins(:recipe).where(['recipe_name LIKE ?', "%#{search}%"])
    elsif tag_id.present?
      joins(recipe: :tags).where(tags: { id: tag_id })
    else
      all  #検索結果が当てはまらない場合は全て表示
    end
  end


end
