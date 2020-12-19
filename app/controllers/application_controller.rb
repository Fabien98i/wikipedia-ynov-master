class ApplicationController < ActionController::Base
    before_action :session_recuperation

    def session_recuperation 
        if session[:user_token] != nil
            user = User.find_by(id: session[:user_token])
            @current_user = user
        end
    end
end
