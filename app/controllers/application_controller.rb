class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  before_action :set_default_response_format
  before_action :set_session_token_from_header
  respond_to :json

  include ErrorsHelper
  include SessionsHelper

  private

  def set_default_response_format
    request.format = :json
  end

  def set_session_token_from_header
    session[:token] ||= request.headers["AuthToken-X"]
  end
end
