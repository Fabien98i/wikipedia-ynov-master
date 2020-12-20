class SessionController < ApplicationController
    def index_sign_in
    end

    def sign_in
        email = params[:login][:email]
        auth_password = params[:login][:password]
        user = User.find_by(email: email)
        find = user && user.authenticate(auth_password)
        if find 
            session[:user_token] = user.id.to_s
            redirect_to '/'
        else
            redirect_to sign_in_path, notice: 'Compte introuvable'
        end
    end

    def sign_out
        session[:user_token] = nil 
        redirect_to sign_in_path
    end

    private 
        def session_params
            params.require(:login).permit(:email, :password)
        end

end
