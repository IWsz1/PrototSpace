class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototype = @user.prototypes.order("created_at DESC")
  end
end
