module ClientsHelper
  def form_submit_action
    @client.persisted? ? "Edit Client" : "Create Client"
  end

  def set_label_class(attr)
    @client.send(attr).present? ? "active" : ""
  end
end
