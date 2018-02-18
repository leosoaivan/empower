class EpisodesController < ApplicationController
  before_action :nil_respondent_if_blank, only: :create
  before_action :set_form_variables, only: [:new, :create]
  before_action :set_episode, only: [:show, :destroy]

  def new
    @petitioner = Client.find(params[:client_id])
    @episode = Episode.new
  end

  def create
    @petitioner = Client.find(params[:client_id])
    @episode = @petitioner.petitioned_episodes.build(episode_params)

    if @episode.save
      flash[:success] = "Episode successfully created"
      redirect_to client_path(@petitioner)
    else
      flash.now[:danger] = "There was an error"
      render :new
    end
  end

  def show
    @client = ClientDecorator.new(@episode.petitioner)
    @contacts = @episode.contacts
  end

  def destroy
    @episode.destroy
    flash[:success] = "The episode was successfully deleted."
    redirect_to client_path(@episode.petitioner)
  end

  private

  def episode_params
    @episode_params ||= params.require(:episode).permit(:arrest, victimization:[], relationship:[], respondent_attributes: [:firstname, :lastname])
  end

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def nil_respondent_if_blank
    if params[:episode][:respondent].blank?
      params[:episode][:respondent] = nil
    end
  end

  def set_form_variables
    @relationships = [
      "Now or previously married",
      "Dating/Romantic/Sexual",
      "Child(ren) in common",
      "Partner in common",
      "Blood relative",
      "Shared residence",
      "Acquaintance",
      "Stranger"
    ]
    @victimizations = [
      "Intimate partner violence",
      "Non-intimate partner violence",
      "Sexual assault",
      "Stalking",
      "Elder abuse",
      "Child abuse",
      "No DV offense disclose"
    ]
  end
end
