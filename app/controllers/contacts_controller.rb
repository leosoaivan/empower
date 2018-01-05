class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    episode = Episode.find(params[:episode_id])
    contact = episode.contacts.build(contact_params.merge(user: current_user))
    if contact.save
      redirect_to episode
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:body)
  end
end
