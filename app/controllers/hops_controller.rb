class HopsController < ApplicationController
  before_action :set_hop, only: [ :edit, :update, :destroy ]

  def index
    @hops = Hop.all.ordered
  end

  def new
    @hop = Hop.new
  end

  def create
    @hop = Hop.new(hop_params)
    if @hop.save
      respond_to do |format|
        format.html { redirect_to hops_path, notice: "Lupulo exitosamente creado." }
        format.turbo_stream { flash.now[:notice] = "Lupulo exitosamente creado." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @hop.update(hop_params)
      respond_to do |format|
        format.html { redirect_to hops_path, notice: "Lupulo exitosamente actualizado." }
        format.turbo_stream { flash.now[:notice] = "Lupulo exitosamente actualizado." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @hop.destroy
      respond_to do |format|
        format.html { redirect_to hops_path, notice: "Lupulo exitosamente eliminado." }
        format.turbo_stream { flash.now[:notice] = "Lupulo exitosamente eliminado." }
      end
    end
  end

  private

  def set_hop
    @hop = Hop.find(params[:id])
  end

  def hop_params
    params.require(:hop).permit(:name, :description, :aroma_profile, :flavor_profile, :alpha_acids)
  end
end
