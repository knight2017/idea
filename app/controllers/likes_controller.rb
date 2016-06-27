class LikesController < ApplicationController

  def create
     @idea = current_idea
     @l = Like.new(idea: current_idea, user: current_user)
     if @l.save
     LikesMailer.notify_post_owner(@l).deliver_later
     redirect_to root_path, notice: " liked"
     else
     redirect_to root_path, alert: "already liked"
     end
  end

  def destroy
    l = Like.find params[:id]
    l.destroy # if can? destroy Favourite
    redirect_to root_path, notice: "un liked"
  end
end
