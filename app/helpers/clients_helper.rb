module ClientsHelper
  def form_submit_action
    @client.persisted? ? "Edit Client" : "Create Client"
  end

  def set_label_class(attr)
    @client.send(attr).present? ? "active" : ""
  end

  def if_client(client, attr)
    client.send(attr) unless client.nil?
  end

  def episodes_any
    if @episodes.present?
      render @episodes
    else
      render 'episodes/no_episodes'
    end
  end

end
