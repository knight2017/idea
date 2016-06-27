class JoinsController < ApplicationController
def index
  @joins = current_user.joining_ideas
end

def create
   j = Join.new(idea: current_idea, user: current_user)
   if j.save
   redirect_to root_path, notice: " joined"
   else
   redirect_to root_path, alert: "already joined"
   end
end

def destroy
  j = Join.find params[:id]
  j.destroy # if can? destroy Favourite
  redirect_to root_path, notice: "un joined"
end
end
