class FoodsController < ApplicationController

  def index
    @foods = Food.page(params[:page]).per(10).order(:unit)
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      @foods = Food.page(params[:page]).per(10)
    else
      @foods = Food.page(params[:page]).per(10)
      render 'index'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @foods = Food.page(params[:page]).per(10)
    @food.destroy
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :unit)
  end
end
