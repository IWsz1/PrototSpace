class PrototypesController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @name = @user.name
  end
end