class MashesController < ApplicationController
  before_action :set_recipe
  before_action :set_mash, only: [:edit, :update]

  def new
    @mash = @recipe.build_mash
  end

  def create
    @mash = @recipe.build_mash(mash_params)
    if @mash.save
      redirect_to recipe_path(@recipe), notice: "Maceracion exitosamente creada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private

  def set_recipe
    @recipe = current_user.recipes.find(params[:recipe_id])
  end

  def set_mash
    @mash = Mash.where(recipe_id: @recipe.id).find(params[:id])
  end

  def mash_params
    params.require(:mash).permit(:water_grain_ratio, :temp, :time, :recirculation_time)
  end
end
