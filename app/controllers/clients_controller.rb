class ClientsController < ApplicationController
  def index
    clients_with_matching_name = ClientsQuery.new(ClientsQuery.new
      .firstname_like(params[:firstname]))
      .lastname_like(params[:lastname])
    @clients = ClientsQuery.new(clients_with_matching_name).id_like(params[:id])
  end

  def show
    @client = Client.find(params[:id])
    @episodes = @client.all_episodes
  end

  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
      flash[:success] = "Client successfully edited"
      redirect_to(@client)
    else
      flash.now[:danger] = "Invalid edit"
      render :edit
    end
  end

  private

  def client_params
    params.require(:client).permit(:firstname, :lastname, :dob, :telephone)
  end
end
