class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save!
      session[:user_id]= @user.id
      flash[:success] = "Thank you for Signing Up."
      redirect_to root_path
    else
      flash[:error] = "#{@user.errors.full_messages.to_sentence}"
      redirect_to root_path
    end
  end

  # def signin
  #   @user = User.new
  # end

  def signup
    @user = User.new
  end

  private
    def user_params
      params.required(:user).permit(:name, :email, :password)
    end
end
