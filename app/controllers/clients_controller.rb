class ClientsController < ApplicationController
  def index
    @clients = Client.search(params)
  end
end
