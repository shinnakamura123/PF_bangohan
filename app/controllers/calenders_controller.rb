class CalendersController < ApplicationController

  def index
    @calenders = Calender.page(params[:page]).per(8)
  end

  def new
    @calender = Calender.new
    @calenders = Calender.all
    @lists = List.joins(:recipe).pluck('lists.id, recipes.recipe_name')
  end

  def create
    @calender = Calender.new(calender_params)
    @calender.user_id = current_user.id
    if @calender.save
      redirect_to request.referer
    else
      render 'new'
    end
  end

  def show
  end

  private

  def calender_params
    params.permit(:start_time)
  end

end
