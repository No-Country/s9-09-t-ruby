class HopsController < ApplicationController
  before_action :set_hop, only: [ :edit, :update, :destroy ]

  def index
    @hops = Hop.all.ordered
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

  def set_hop
    @hop = Hop.find(params[:id])
  end

  def hop_params
    params.require(:hop).permit(:name, :description, :aroma_profile, :flavor_profile, :alpha_acids)
  end
end
