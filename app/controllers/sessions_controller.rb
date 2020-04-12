class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:params])
            render plain: "You have entered the correct password"
        else
            render plain: "Incorrect Password"
        end
    end

end  