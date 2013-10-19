class GoalsController < ApplicationController

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.build(params[:goal])
    if @goal.save
      redirect_to user_url(@goal.author)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    @user_cheer_count = current_user.cheers_today
    render :show
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
      redirect_to user_url(@goal.author)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @author = @goal.author
    if @goal.destroy
      redirect_to user_url(@author)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to goal_url(@goal)
    end
  end

end
