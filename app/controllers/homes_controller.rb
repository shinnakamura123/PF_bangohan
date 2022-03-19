class HomesController < ApplicationController

  def top
    @favorite_ranks = Recipe.find(Favorite.group(:recipe_id).order('count(recipe_id) desc').limit(10).pluck(:recipe_id))
    @follower_ranks = User.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(10).pluck(:followed_id))
  end

  def about
  end
end
