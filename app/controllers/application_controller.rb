class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :get_params
  include BootstrapFlashHelper
  def get_params
    @controller_from_appc = params[:controller]
    @action_from_appc = params[:action]
    @params_from_appc = params
  end

  def after_sign_in_path_for(resource)
    #	puts "Application#after_sign_in_path_for(resource)"
    transactions_path
  end
  def authourise_resource(options={})
    authourised = case options[:resource]
    when 'account'
      Account.owns_account?(options[:user_id],options[:account_id])
    when 'transaction'

    end
    authourised
end
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception
end
