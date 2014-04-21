class ApplicationController < ActionController::Base
	before_action :authenticate_user!
  def after_sign_in_path_for(resource)
  	puts "Application#after_sign_in_path_for(resource)"
  	transactions_path
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
