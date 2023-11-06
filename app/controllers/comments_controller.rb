class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.valid?
      redirect_to prototype_path(@comment.prototype_id)
    else
      @prototype = Prototype.find(@comment.prototype_id)
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user).order("created_at DESC")
      render "prototypes/show"
    end
  end
  private
  def comment_params
    # マイグレーションファイルにてreferences:userと作成したカラムは自動でuser_idとなって作成される
    params.require(:comment).permit(:content).merge(user_id: current_user.id,prototype_id:params[:prototype_id])
  end
end
