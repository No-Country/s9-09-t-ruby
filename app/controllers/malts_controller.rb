class MaltsController < ApplicationController
  before_action :set_malt, only: [ :edit, :update, :destroy ]

  def index
    @malts = Malt.all
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

  def set_malt
    @malt = Malt.find(params[:id])
  end
end
