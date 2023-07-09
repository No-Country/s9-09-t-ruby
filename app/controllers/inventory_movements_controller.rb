class InventoryMovementsController < ApplicationController
  before_action :set_inventory_item, :set_movement_type

  def new
    @inventory_movement = @inventory_item.inventory_movements.build
  end

  def create
    @inventory_movement = @inventory_item.inventory_movements.build(inventory_movement_params)
    @inventory_movement.movement_type = @movement_type
    if @inventory_movement.save
      respond_to do |format|
        format.html { redirect_to "/#{@inventory_item.inventoriable_type.pluralize.downcase}", notice: "Movimiento exitosamente creado." }
        format.turbo_stream { flash.now[:notice] = "Movimiento exitosamente creado." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_movement_type
    @movement_type = params[:movement_type]
  end

  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:inventory_item_id])
  end

  def inventory_movement_params
    params.require(:inventory_movement).permit(:quantity, :movement_type)
  end
end
