class YeastsController < ApplicationController
  before_action :set_yeast, only: [ :edit, :update, :destroy ]

  def index
    @yeasts = current_user.yeasts.includes(:inventory_item).ordered
  end

  def new
    @yeast = current_user.yeasts.new
  end

  def create
    @yeast = current_user.yeasts.new(yeast_params)
    if @yeast.save
      respond_to do |format|
        format.html { redirect_to yeasts_path, notice: "Levadura exitosamente creada." }
        format.turbo_stream { flash.now[:notice] = "Levadura exitosamente creada." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @yeast.update(yeast_params)
      respond_to do |format|
        format.html { redirect_to yeasts_path, notice: "Levadura exitosamente editada." }
        format.turbo_stream { flash.now[:notice] = "Levadura exitosamente editada." }
      end
    else
    end
  end

  def destroy
    if @yeast.destroy
      respond_to do |format|
        format.html { redirect_to yeasts_path, notice: "Levadura exitosamente eliminada." }
        format.turbo_stream { flash.now[:notice] = "Levadura exitosamente eliminada." }
      end
    end
  end

  private

  def set_yeast
    @yeast = current_user.yeasts.find(params[:id])
  end

  def yeast_params
    params.require(:yeast).permit(:name, :description, :dosage, :yeast_type, :attenuation)
  end
end
