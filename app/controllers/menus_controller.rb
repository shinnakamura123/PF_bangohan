class MenusController < ApplicationController

  def index
    @menus = Menu.where(user_id: current_user.id)
    @menu = Menu.new
  end

  def new
    @menu = Menu.new
    @menus = Menu.where(user_id: current_user.id)
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id
    @menu.save
    redirect_to request.referer
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    redirect_to request.referer
  end

  def show
    @menu = Menu.find(params[:id])
    #その日の献立を取得
    @menus = Menu.where(start_time: @menu.start_time.in_time_zone.all_day)
    # 同じ材料の時に加算されるように以下を記述
    # 空の変数宣言（後で使う用）
    @foods = {}
    @menus.each do |menu|
      menu.recipe.recipe_foods.each do |recipe_food|
        #recipe_food.food.idに紐づく@foodsのデータがなかったら
        if @foods[recipe_food.food.id].nil?
          #空の変数宣言
          @foods[recipe_food.food.id] = {}
          # 名称
          @foods[recipe_food.food.id]['food_name'] = recipe_food.food.food_name
          #後で数量加算するときにエラーにならないようにとりあえず数量0を突っ込む
          @foods[recipe_food.food.id]['quantity'] = recipe_food.quantity.to_i
          # 単位
          @foods[recipe_food.food.id]['unit'] = recipe_food.food.unit
        else
          # 分量を加算
          @foods[recipe_food.food.id]['quantity'] += recipe_food.quantity.to_i
        end
      end
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:user_id, :recipe_id, :start_time)
  end

end
