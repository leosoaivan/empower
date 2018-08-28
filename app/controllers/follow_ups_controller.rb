class FollowUpsController < ApplicationController
  before_action :define_shifts, only: [:new, :create]
  
  def index
  end

  def show
  end
  
  def new
    @episode = Episode.find(params[:episode_id])
  end

  def edit
  end
  
  def create
    @episode = Episode.find(params[:episode_id])
    @follow_up = @episode.follow_ups.build(follow_up_params)

    if @follow_up.save
      redirect_to episode_path(@episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def follow_up_params
    params.require(:follow_up).permit(:due_by_date, :due_by_shift, :user_id)
  end

  def define_shifts
    @shifts = {
      "morning": 1,
      "afternoon": 2,
      "evening": 3,
      "overnight": 4
    }
  end
end
