class ClientsController < ApplicationController
  load_and_authorize_resource except: [:index, :show]
    
  def new
  end
  
  def create
    if @client.save
      flash[:success] = "Client was successfully created."
      redirect_to @client
    else
      flash.now[:danger] = "There was an error. Try again."
      render :new
    end
  end

  def index
    if search_params.presence
      clients = Client.chain_scopes_for_searching(search_params.to_hash)

      @clients = decorated_clients(clients)
    end

    @clients ||= decorated_clients(Client.all)

    respond_to do |format|
      format.json { render json: @clients.map(&:fullname_and_dob) }
      format.html { render :index }
    end
  end

  def show
    client = Client.find(params[:id])
    @client = ClientDecorator.new(client)
    @episodes = @client.petitioned_episodes.includes(:respondent).desc_order
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
      @client = ClientDecorator.new(@client)
      @episodes = @client.petitioned_episodes.includes(:respondent).desc_order
      render :show, locals: { client: @client, episodes: @episodes }
    else
      @client.destroy
      flash[:success] = "Client successfully deleted."
      redirect_to clients_path
    end
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :dob, :telephone)
  end

  def search_params
    params.permit(
      :where_id,
      :where_first_name_like,
      :where_last_name_like
    )
  end

  def decorated_clients(clients)
    clients.map { |client| ClientDecorator.new(client) }
  end
end
