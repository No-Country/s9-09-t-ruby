class RecipesController < ApplicationController
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy ]

  def index
    @recipes = Recipe.all.ordered
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_recipe
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :style, :batch)
  end
end
