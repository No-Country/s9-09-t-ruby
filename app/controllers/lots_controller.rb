class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :edit, :update, :destroy, :trigger, :trigger_todo]

  def index
    @creado_lots = current_user.lots.where(status: :creado).includes(:recipe).ordered
    @en_maceracion_lots = current_user.lots.where(status: :en_maceracion).includes(:recipe).ordered
    @en_coccion_lots = current_user.lots.where(status: :en_coccion).includes(:recipe).ordered
    @en_fermentacion_lots = current_user.lots.where(status: :en_fermentacion).includes(:recipe).ordered
  end

  def show
    @ingredient_items_quantities = @lot.recipe.ingredient_items_quantities(@lot.batch)
    @mashing_todo = @lot.todos.where(todo_type: :maceracion).first
    @boiling_todo = @lot.todos.where(todo_type: :coccion).first
    @chilling_todo = @lot.todos.where(todo_type: :enfriamiento).first
    @fermentation_todo = @lot.todos.where(todo_type: :fermentacion).first
  end

  def new
    @lot = current_user.lots.build
  end

  def create
    @lot = current_user.lots.build(lot_params)
    if @lot.save
      respond_to do |format|
        format.html { redirect_to lots_path, notice: "Lote exitosamente creado." }
        format.turbo_stream { flash.now[:notice] = "Lote exitosamente creado." }
      end
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @lot.update(lot_params)
      respond_to do |format|
        format.html { redirect_to lots_path, notice: "Lote exitosamente editado." }
        format.turbo_stream { flash.now[:notice] = "Lote exitosamente editado." }
      end
    else
    end
  end

  def destroy
    if @lot.destroy
      respond_to do |format|
        format.html { redirect_to lots_pah, notice: "Lote exitosamente eliminado" }
        format.turbo_stream { flash.now[:notice] = "Lote exitosamente eliminado" }
      end
    end
  end

  def trigger
    if @lot.send "#{params[:event]}!"
      respond_to do |format|
        format.html { redirect_to lot_path(@lot), notice: "Estado del lote cambiada exitosamente." }
      end
    else
      redirect_to lots_path, status: :unprocessable_entity, notice: "No se ha podido validar el estado del lote."
    end
  end

  def trigger_todo
    @todo = @lot.todos.find(params[:todo_id])
    if @todo.send "#{params[:event]}!"
      respond_to do |format|
        format.html { redirect_to lot_path(@lot), notice: "Estado de la tarea cambiada exitosamente." }
      end
    else
      redirect_to lot_path(@lot), status: :unprocessable_entity, notice: "No se ha podido validar el estado de la tarea."
    end
  end

  private

  def set_lot
    @lot = current_user.lots.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:batch, :recipe_id)
  end
end
