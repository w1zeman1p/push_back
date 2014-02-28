class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_default_response_format
  respond_to :json

  include ErrorsHelper
  include SessionsHelper


  def set_default_response_format
    request.format = :json
  end
end
