class IngredientItemsController < ApplicationController
  before_action :set_recipe, :set_addable_type
  before_action :set_ingredient_item, only: [ :edit, :update, :destroy ]

  def new
    @ingredient_item = @recipe.ingredient_items.build
  end

  def create
    @ingredient_item = @recipe.ingredient_items.build(ingredient_item_params)
    if @ingredient_item.save
      respond_to do |format|
        format.html { redirect_to recipe_path(@recipe), notice: "Ingrediente exitosamente creado." }
        format.turbo_stream { flash.now[:notice] = "Ingrediente exitosamente creado." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_addable_type
    @addable_type = params[:addable_type]
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_ingredient_item
    @ingredient_item = @recipe.ingredient_items.find(params[:id])
  end

  def ingredient_item_params
    params.require(:ingredient_item).permit(:quantity, :addable_type, :addable_id)
  end
end
