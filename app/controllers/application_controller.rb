class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find_by(id: session[:cart_id])
    end

    if @current_cart.nil?
      @current_cart = Cart.create(user: current_user)
      session[:cart_id] = @current_cart.id
    elsif current_user && @current_cart.user != current_user
      @current_cart.update(user: current_user)
    end

    @current_cart
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path, alert: "Доступ заборонено!" unless current_user.admin?
  end
end