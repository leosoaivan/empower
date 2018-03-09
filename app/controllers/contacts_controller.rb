class ContactsController < ApplicationController
  before_action :find_parent_episode, only: [:new, :create]

  def new
    @contact = Contact.new
    @service_types = ServiceType.all
  end

  def create
    contact = @episode.contacts.build(contact_params.merge(user: current_user))
    services = Service.where(name: contact_params[:services])
    contact.services << services

    if contact.save
      flash[:success] = "Contact successfully created."
      redirect_to episode_path(@episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      @contact = Contact.new
      @service_types = ServiceType.all
      render :new
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    @service_types = ServiceType.all
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update_attributes(contact_params)
      flash[:success] = "Contact successfully edited."
      redirect_to episode_path(contact.episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      @contact = Contact.find(params[:id])
      @service_types = ServiceType.all
      render :edit
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])

    if @contact.destroy
      respond_to do |format|
        format.js { flash.now[:success] = "Contact successfully deleted." }
      end
    end
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:body, service_ids:[])
  end
  
  def find_parent_episode
    @episode = Episode.find(params[:episode_id])
  end
end
