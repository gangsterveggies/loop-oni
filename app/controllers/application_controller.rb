class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  before_filter :set_user_language

  private
    def set_user_language
      I18n.locale = 'pt'
    end
end
