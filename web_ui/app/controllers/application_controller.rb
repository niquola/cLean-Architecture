class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def system
    @system ||= System
    .new("#{File.dirname(__FILE__)}/../../../use_cases")
  end
end
