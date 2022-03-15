class StepsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @step = @recipe.steps.new(step_params)
    if @step.save
      redirect_to request.referer
    else
      render request.referer
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    redirect_to request.referer
  end

  private

  def step_params
    params.require(:step).permit(:method, :recipe_id, :image)
  end
end
