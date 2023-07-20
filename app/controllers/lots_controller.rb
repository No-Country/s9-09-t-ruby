class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :edit, :update, :destroy, :trigger]

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

  def trigger
    if @lot.send "#{params[:event]}!"
      respond_to do |format|
        redirect_to lots_path, notice: "Estado del lote cambiada exitosamente."
      end
    else
      redirect_to lots_path, status: :unprocessable_entity, notice: "No se ha podido validar el estado del lote."
    end
  end

  private

  def set_lot
    @lot = current_user.lots.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:batch)
  end
end
