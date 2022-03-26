class HomesController < ApplicationController

  def top
    @recipes = Recipe.where(status: false).order(created_at: :desc).limit(2)
  end

  def about
  end
end
