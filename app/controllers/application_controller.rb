class ApplicationController < ActionController::Base
  protect_from_forgery
    
    def require_admin!
      logger.debug "ApplicationController::require_admin!"
      unless current_user && current_user.try(:is_admin?)
        flash[:notice] = "Devi essere un amministratore per accedere a questa pagina"
        redirect_to "/users/sign_in"
      end
    end
    
    
end
