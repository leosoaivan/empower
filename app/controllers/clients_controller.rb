class ClientsController < ApplicationController
  def index
    clients_with_matching_name = ClientsQuery.new(ClientsQuery.new
      .firstname_like(params[:firstname]))
      .lastname_like(params[:lastname])
    @clients = ClientsQuery.new(clients_with_matching_name).id_like(params[:id])
  end
end
