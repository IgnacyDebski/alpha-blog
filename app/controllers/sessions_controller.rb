class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Gratulacje, zalogowałeś się poprawnie/You have successfully logged in"
      redirect_to users_path(user)
    else
      flash.now[:danger] = "Coś jest nie tak z twoimi danymi logowania/There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Wylogowałeś się/You have logged out"
    redirect_to root_path
  end

end
