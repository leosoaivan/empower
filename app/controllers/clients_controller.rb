class ClientsController < ApplicationController
  before_action :find_client, only: [:show, :edit, :update, :destroy]
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    
    if @client.save
      flash[:success] = "Client was successfully created."
      redirect_to @client
    else
      flash.now[:danger] = "There was an error. Try again."
      render :new
    end
  end

  def index
    @clients = decorated_clients
  end

  def show
    @episodes = @client.petitioned_episodes.includes(:respondent)
  end

  def edit
  end
  
  def update
    if @client.update_attributes(client_params)
      flash[:success] = "Client was successfully edited."
      redirect_to(@client)
    else
      flash.now[:danger] = "There was an error. Try again."
      render :edit
    end
  end

  def destroy
    if @client.all_episodes.present?
      flash[:danger] = "This client has episodes, or is the respondent in other episodes. Client cannot be deleted."
      redirect_to client_path @client
    else
      @client.destroy
      flash[:success] = "Client successfully deleted."
      redirect_to clients_path
    end
  end

  private

  def client
    Client.find(params[:id])
  end

  def find_client
    @client = ClientDecorator.new(client)
  end

  def client_params
    params.require(:client).permit(:firstname, :lastname, :dob, :telephone)
  end

  def queried_clients
    clients_with_matching_name = ClientsQuery.new(ClientsQuery.new
      .firstname_like(params[:firstname]))
      .lastname_like(params[:lastname])
    @clients = ClientsQuery.new(clients_with_matching_name).id_like(params[:id])
  end

  def decorated_clients
    queried_clients.map { |client| ClientDecorator.new(client) }
  end
end
