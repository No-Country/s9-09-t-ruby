class MaltsController < ApplicationController
  before_action :set_malt, only: [ :edit, :update, :destroy ]

  def index
    @malts = Malt.all.ordered
  end

  def new
    @malt = Malt.new
  end

  def create
    @malt = Malt.new(malt_params)
    if @malt.save
      respond_to do |format|
        format.html { redirect_to malts_path, notice: "Malta exitosamente creada." }
        format.turbo_stream { flash.now[:notice] = "Malta exitosamente creada." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @malt.update(malt_params)
      respond_to do |format|
        format.html { redirect_to malts_path, notice: "Malta exitosamente actualizada." }
        format.turbo_stream { flash.now[:notice] = "Malta exitosamente actualizada." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @malt.destroy
      respond_to do |format|
        format.html { redirect_to malts_path, notice: "Malta exitosamente eliminada." }
        format.turbo_stream { flash.now[:notice] = "Malta exitosamente eliminada." }
      end
    end
  end

  private

  def set_malt
    @malt = Malt.find(params[:id])
  end

  def malt_params
    params.require(:malt).permit(:name, :description, :extract, :color, :ph)
  end
end
