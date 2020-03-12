class UsersController < ApplicationController
    skip_before_action  :verify_authenticity_token
    def index
        render plain: User.all.map{|user| user.to_pleasant_string}.join("\n")
    end
    
    def show 
        id=params[:id]
        user=User.find(id)
        render plain: user.to_pleasant_string
    end
    
    def create 
        name=params[:name]
        email=params[:email]
        password=params[:password]
        new_user= User.create!(
          name: name, 
          email: email, 
          password: password
        )
        render plain: "Hey a new user is create with the ID #{new_user.id}"
    end

    
end
  