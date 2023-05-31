class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] =@user["id"]
        redirect_to "/places"
        flash["notice"] = "Welcome, #{@user["username"]}!"
      else    
        flash["notice"] = "Nope."
        redirect_to "/sessions/new" 
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil # we have to end the cookies
    flash["notice"] = "Goodbye."
    redirect_to "/sessions/new"
  end
end
  