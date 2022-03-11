class FoodsController < ApplicationController

  def index
    @foods = Food.page(params[:page]).per(10)
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to request.referer
    else
      render 'index'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to request.referer
  end

  private

  def food_params
    params.permit(:food_name, :unit)
  end
end
