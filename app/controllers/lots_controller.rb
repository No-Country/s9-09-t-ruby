class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :edit, :update, :destroy]

  def index
    @creado_lots = current_user.lots.where(status: :creado).includes(:recipe)
    @en_maceracion_lots = current_user.lots.where(status: :en_maceracion).includes(:recipe)
    @en_coccion_lots = current_user.lots.where(status: :en_coccion).includes(:recipe)
    @en_fermentacion_lots = current_user.lots.where(status: :en_fermentacion).includes(:recipe)
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

  def set_lot
  end

  def lot_params
    params.require(:lot).permit(:batch)
  end
end
