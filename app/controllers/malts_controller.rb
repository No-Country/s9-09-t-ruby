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
      redirect_to malts_path, notice: "Malta exitosamente creada."
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

  def set_malt
    @malt = Malt.find(params[:id])
  end

  def malt_params
    params.require(:malt).permit(:name, :description, :extract, :color, :ph)
  end
end
