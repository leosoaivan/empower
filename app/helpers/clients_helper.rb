module ClientsHelper
  def form_submit_action
    @client.persisted? ? "Edit Client" : "Create Client"
  end
end
