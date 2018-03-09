class ContactsController < ApplicationController
  before_action :set_parent_episode, only: [:new, :create]
  before_action :set_service_types, only: [:new, :create, :edit, :update]
  before_action :find_contact, only: [:new, :edit, :update, :destroy]

  def new
  end

  def create
    @contact = @episode.contacts.build(contact_params.merge(user: current_user))
    services = Service.where(name: contact_params[:services])
    @contact.services << services

    if @contact.save
      flash[:success] = "Contact successfully created."
      redirect_to episode_path(@episode)
    else
      flash[:danger] = "There was an error. Please try again."
      render :new, locals: { contact: @contact, service_types: @service_types }
    end
  end

  def edit
  end

  def update
    if @contact.update_attributes(contact_params)
      flash[:success] = "Contact successfully edited."
      redirect_to episode_path(@contact.episode)
    else
      flash.now[:danger] = "There was an error. Please try again."
      render :edit, locals: { contact: @contact, service_types: @service_types }
    end
  end
  
  def destroy
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
  
  def set_parent_episode
    @episode = Episode.find(params[:episode_id])
  end

  def find_contact
    @contact = Contact.find_or_initialize_by(id: params[:id])
  end

  def set_service_types
    @service_types = ServiceType.all
  end
end
