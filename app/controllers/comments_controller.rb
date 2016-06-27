class CommentsController < ApplicationController
  def comment_params
    params.require(:comment).permit(:body)
  end
  def create
    @idea = Idea.find params[:idea_id]
    @comment = @idea.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_to @idea, notice: "comment Created"
    else
      redirect_to new_user_path
    end
  end

  def destroy
    comment =  Comment.find params[:id]
    comment.destroy
    redirect_to root_path, notice: "deleted"
  end

end
