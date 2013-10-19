class CheersController < ApplicationController

  before_filter :redirect_if_user_cheer_count_over_5!

  def create
    @cheer = Cheer.new(goal_id: params[:goal_id], user_id: current_user.id)
    if @cheer.save
      redirect_to goal_url(@cheer.goal)
    else
      flash[:errors] = @cheer.errors.full_messages
      redirect_to goal_url(@cheer.goal)
    end
  end


  private

  def redirect_if_user_cheer_count_over_5!
    if current_user.cheers_today >= 5
      flash[:errors] = ["No more cheers for today!"]
      redirect_to user_url(current_user)
    end
  end

end
