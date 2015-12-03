class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Policy::NotAuthorized do
    render 'not_authorized', status: :forbidden
  end

  def authorize(record)
    policy(record).authorize(params[:action])
  end

  def policy(record)
    Policy.for(record, current_user)  
  end

end
