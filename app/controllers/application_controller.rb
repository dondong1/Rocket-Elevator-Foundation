class ApplicationController < ActionController::Base
          
    skip_before_action :verify_authenticity_token 
    protect_from_forgery prepend: true, with: :exception
    
    # Probably add more here to restrict users from directly accessing the back-office
    # def require_admin # This is from Blazer..
    #     # depending on your auth, something like...
    #     redirect_to root_path unless current_user && current_user.superadmin?
    # end

    protected
    #Jorge - redirecto to home after signin or signup
    def after_sign_in_path_for(resource)
        '/index'
    end

    def after_sign_up_path_for(resource)
        '/index' 
    end

    def is_employee?
        if !current_user || !current_user.employee
            redirect_to '/index', alert: "You need to be a employee"
        elsif  current_user and (current_user.superadmin_role? or current_user.employee) 
        else
            redirect_to '/index', alert: "You need to be a employee"
        end
    end

end
