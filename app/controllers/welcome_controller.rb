class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
 layout "welcomehome"
  def index
  end

end
