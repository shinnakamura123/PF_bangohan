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
    @menus = Menu.where(start_time: @menu.start_time.in_time_zone.all_day)
  end

  private

  def menu_params
    params.require(:menu).permit(:user_id, :recipe_id, :start_time)
  end

end
