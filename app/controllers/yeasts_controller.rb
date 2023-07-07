class YeastsController < ApplicationController
  before_action :set_yeast, only: [ :edit, :update, :destroy ]

  def index
    @yeasts = Yeast.all.ordered
  end

  def new
    @yeast = Yeast.new
  end

  def create
    @yeast = Yeast.new(yeast_params)
    if @yeast.save
      redirect_to yeasts_path, notice: "Levadura exitosamente creada."
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

  def set_yeast
    @yeast = Yeast.find(params[:id])
  end

  def yeast_params
    params.require(:yeast).permit(:name, :description, :dosage, :yeast_type)
  end
end
