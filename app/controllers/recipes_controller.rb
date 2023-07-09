class RecipesController < ApplicationController
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy ]

  def index
    @recipes = Recipe.all.ordered
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      respond_to do |format|
        format.html { redirect_to recipes_path, notice: "Receta exitosamente creada." }
        format.turbo_stream { flash.now[:notice] = "Receta exitosamente creada." }
      end
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      respond_to do |format|
        format.html { redirect_to recipes_path, notice: "Receta exitosamente actualizada." }
        format.turbo_stream { flash.now[:notice] = "Receta exitosamente actualizada." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @recipe.destroy
      respond_to do |format|
        format.html { edirect_to recipes_path, notice: "Receta exitosamente eliminada." }
        format.turbo_stream { flash.now[:notice] = "Receta exitosamente eliminada." }
      end
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :style, :batch)
  end
end
