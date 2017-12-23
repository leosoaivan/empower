class ClientsController < ApplicationController
  before_action :find_client, only: [:show, :edit, :update]

  def index
    clients_with_matching_name = ClientsQuery.new(ClientsQuery.new
      .firstname_like(params[:firstname]))
      .lastname_like(params[:lastname])
    @clients = ClientsQuery.new(clients_with_matching_name).id_like(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = "Client was successfully created."
      redirect_to @client
    else
      flash.now[:error] = "There was an error. Try again."
      render :new
    end
  end

  def show
    @episodes = @client.all_episodes
  end

  def edit
    @client = Client.find(params[:id])
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

  private

  def find_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:firstname, :lastname, :dob, :telephone)
  end
end
