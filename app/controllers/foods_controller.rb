class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.page(params[:page]).per(10).order(:unit)
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @foods = Food.page(params[:page]).per(10)
    @food.save
    flash.now[:notice] = '材料を登録しました。'
  end

  def destroy
    @food = Food.find(params[:id])
    @foods = Food.page(params[:page]).per(10)
    @food.destroy
    flash.now[:alert] = '材料を削除しました。'
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :unit)
  end
end
