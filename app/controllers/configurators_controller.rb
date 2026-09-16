class ConfiguratorsController < ApplicationController
  def show
    @default_params = {
      width: 1300,
      height: 1400,
      profile_system: "rehau_70",
      glass_type: "double",
      hardware: "siegenia",
      with_installation: true
    }
    @initial_price = WindowPriceCalculator.calculate(@default_params)
  end

  def calculate
    price = WindowPriceCalculator.calculate(calc_params)
    render json: { price: price }
  end

  def create
    price = WindowPriceCalculator.calculate(config_params)
    @config = CustomConfiguration.new(config_params)
    @config.calculated_price = price
    @config.configuration_data = {
      profile_label: config_params[:profile_system].humanize,
      glass_label: config_params[:glass_type].humanize,
      hardware_label: config_params[:hardware].humanize,
      dimensions: "#{config_params[:width]} x #{config_params[:height]} мм"
    }

    if @config.save
      redirect_to configurator_path, notice: "Конфігурацію успішно збережено! Вартість: #{@config.calculated_price} грн"
    else
      redirect_to configurator_path, alert: "Помилка при розрахунку: перевірте введені габарити."
    end
  end

  private

  def calc_params
    params.permit(:width, :height, :profile_system, :glass_type, :hardware, :with_installation)
  end

  def config_params
    params.require(:custom_configuration).permit(:width, :height, :profile_system, :glass_type, :hardware, :with_installation, :product_type)
  end
end