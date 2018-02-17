module ClientsHelper
  def form_submit_action
    @client.persisted? ? "Edit Client" : "Create Client"
  end

  def set_label_class(attr)
    @client.send(attr).present? ? "active" : ""
  end

  def return_attribute_if_respondent(respondent, attr)
    respondent.send(attr) unless respondent.nil?
  end

  def decorated_respondent(respondent, attr)
    ClientDecorator.new(respondent).send(attr) unless respondent.nil?
  end

  def display_client_episodes
    if @episodes.present?
      render @episodes
    else
      render 'episodes/no_episodes'
    end
  end

end
