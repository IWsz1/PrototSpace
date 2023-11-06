class PrototypesController < ApplicationController

  before_action :move_to_index, except:[:index,:show]
  before_action :edit_regulation, only:[:edit]

  def index
    # current_userがいない時にcurrent_userを呼ぼうとするのノーメソッドエラーになるため
    if user_signed_in?
      # current_user.idで該当レコードが取得できる
      @user = User.find(current_user.id)
      # 該当レコードの名前を抽出
      @name = @user.name
    end
      @prototype = Prototype.includes(:user)
  end
  def new
    @prototype = Prototype.new
  end
  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.valid?
      redirect_to root_path
    else
      render "new"
    end
  end
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user).order("created_at DESC")
  end
  def edit
    @prototype = Prototype.find(params[:id])
  end
  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.valid?
      redirect_to prototype_path(params[:id])
    else
      render "edit"
    end
  end
  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end
  private
  def prototype_params
    # マイグレーションファイルにてreferences:userと作成したカラムは自動でuser_idとなって作成される
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end
end

def move_to_index
  unless user_signed_in?
    redirect_to action: :index
  end
end
def edit_regulation
  @prototype = Prototype.find(params[:id])
  @prototype_user =@prototype.user_id
  @user = User.find(current_user.id)
  @current_user = @user.id
  unless user_signed_in? && @prototype_user == @current_user
    redirect_to action: :index
  end
end