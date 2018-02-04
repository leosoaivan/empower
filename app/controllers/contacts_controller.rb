class ContactsController < ApplicationController
  before_action :find_parent_episode, only: [:new, :create]

  def new
    @contact = Contact.new
  end

  def create
    contact = @episode.contacts.build(contact_params.merge(user: current_user))

    if contact.save
      flash[:success] = "Contact successfully created."
      redirect_to episode_path(@episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      @contact = Contact.new
      render :new
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    
    if contact.destroy
      flash[:success] = "Contact successfully deleted."
      redirect_to episode_path(contact.episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      redirect_to episode_path(contact.episode)
    end
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:body)
  end
  
  def find_parent_episode
    @episode = Episode.find(params[:episode_id])
  end
end
