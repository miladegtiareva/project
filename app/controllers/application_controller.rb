class ApplicationController < ActionController::Base
include Pundit::Authorization
include Authentication
include Devise
rescue_from ActiveRecord::RecordNotFound, with: :notfound
before_action :set_locale

private

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
private

def notfound(exeption)
    logger.warn exeption
    render file: 'public/404.html', status: :not_found, layout: false
end 

end
