class GeneralConfigurationsController < ApplicationController
  before_action :set_general_configuration

  def edit
  end

  def update
    if @general_configuration.update(general_configuration_params)
      respond_to do |format|
        format.html { redirect_to recipes_path, notice: "Configuraciones generales exitosamente editados." }
        format.turbo_stream { flash.now[:notice] = "Configuraciones generales exitosamente editados." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def general_configuration_params
    params.require(:general_configuration).permit(
      :efficiency_extract,
      :evaporation_percentage,
      :bioling_time,
      :loss_temp,
      :grain_temp,
      :water_grain_ratio,
      :mashing_temp,
      :sparging_temp,
      :sparging_time,
      :chilling_time,
      :turbiduty_loss
    )
  end

  def set_general_configuration
    @general_configuration = GeneralConfiguration.where(user_id: current_user.id).find(params[:id])
  end
end
