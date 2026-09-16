class WindowPriceCalculator
  PROFILE_RATES = {
    "rehau_60"     => 750.0,
    "rehau_70"     => 1100.0,
    "salamander"   => 1350.0,
    "wds_500"      => 650.0
  }.freeze

  GLASS_RATES = {
    "single"       => 800.0,
    "double"       => 1250.0,
    "energy_saver" => 1600.0
  }.freeze

  HARDWARE_RATES = {
    "roto"     => 850.0,
    "siegenia" => 950.0,
    "axor"     => 550.0
  }.freeze

  INSTALLATION_COEFFICIENT = 1.20

  def self.calculate(params)
    new(params).calculate
  end

  def initialize(params)
    @width = params[:width].to_f
    @height = params[:height].to_f
    @profile = params[:profile_system]
    @glass = params[:glass_type]
    @hardware = params[:hardware]
    @with_installation = ActiveModel::Type::Boolean.new.cast(params[:with_installation])
  end

  def calculate
    # Сувора інженерна валідація мінімальних габаритів
    return 0.0 if @width < 400 || @height < 400 || @width > 3000 || @height > 2800

    area = (@width * @height) / 1_000_000.0
    perimeter = (2 * (@width + @height)) / 1_000.0

    k_profile = PROFILE_RATES.fetch(@profile, 800.0)
    k_glass = GLASS_RATES.fetch(@glass, 1000.0)
    price_hardware = HARDWARE_RATES.fetch(@hardware, 600.0)
    k_install = @with_installation ? INSTALLATION_COEFFICIENT : 1.0

    base_cost = (area * k_glass) + (perimeter * k_profile)
    total = (base_cost * k_install) + price_hardware

    total.round(2)
  end
end