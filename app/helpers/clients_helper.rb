module ClientsHelper
  def form_submit_action
    @client.persisted? ? "Edit Client" : "Create Client"
  end

  def set_label_class(attr)
    @client.send(attr).present? ? "active" : ""
  end

  def if_client(client, attr)
    unless client.nil?
      episode.respondent.sent(attr)
    end
  end
end
