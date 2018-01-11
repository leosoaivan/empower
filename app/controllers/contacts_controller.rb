class ContactsController < ApplicationController
  before_action :set_parent_objects, only: [:new, :create]

  def new
    @contact = Contact.new
  end

  def create
    contact = @episode.contacts.build(contact_params.merge(user: current_user))

    if contact.save
      flash[:success] = "Contact successfully created."
      redirect_to client_episode_path(@episode.petitioner, @episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      @contact = Contact.new
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:body)
  end

  def set_parent_objects
    @petitioner = Client.find(params[:client_id])
    @episode = Episode.find(params[:episode_id])
  end
end
